"""Compute Stream A, Stream B and combined scores from data/scores.json using docs/rubric.json.
Writes data/rankings.json (read by the Typst reports) and data/rankings.csv.
Usage: uv run python3 -I scripts/rank.py  (run from the repo root)"""
import csv, json

rub = json.load(open("docs/rubric.json"))
sc = json.load(open("data/scores.json"))
A = {c["id"]: c["weight"] for c in rub["stream_a"]}
B = [c["id"] for c in rub["stream_b"]]
THRESH = rub["viability_min_seats"]

rows = []
for p in sc["parties"]:
    s = p["scores"]
    a = sum(A[k] * (s[k]["score"] or 0) / 5 for k in A)
    bs = [s[k]["score"] for k in B if s.get(k, {}).get("score") is not None]
    b = sum(bs) / len(bs) * 20 if len(bs) >= rub["stream_b_min_items"] else None
    row = {"slug": p["slug"], "party_en": p["party_en"], "leader": p.get("leader", ""),
           "polled_seats": p.get("polled_seats"), "on_ballot": p.get("on_ballot", True),
           "a": round(a, 1), "b": None if b is None else round(b, 1), "b_items": len(bs),
           "a6": s["A6"]["score"], "excluded": (s.get("B3", {}).get("score") is not None and s["B3"]["score"] <= 1)}
    for w in rub["combined_weights"]:
        key = f"combined_{int(w * 100)}"
        row[key] = round(w * a + (1 - w) * b, 1) if b is not None else None
    row["viable"] = (row["polled_seats"] or 0) >= THRESH
    rows.append(row)

rows = [r for r in rows if r["on_ballot"]]
for key in ["a"] + [f"combined_{int(w * 100)}" for w in rub["combined_weights"]]:
    # Lists without enough Stream B evidence sort by 0.7 x A (B treated as 0), not below every scored list.
    order = sorted(rows, key=lambda r: -(r[key] if r[key] is not None else rub["combined_weights"][0] * r["a"] if key != "a" else r["a"]))
    for i, r in enumerate(order, 1):
        r[f"rank_{key}"] = i
primary = f"combined_{int(rub['combined_weights'][0] * 100)}"
cand = sorted([r for r in rows if r["viable"] and not r["excluded"] and r[primary] is not None], key=lambda r: -r[primary])
below = sorted([r for r in rows if not r["viable"] and not r["excluded"] and r[primary] is not None], key=lambda r: -r[primary])
out = {"primary_key": primary, "rows": sorted(rows, key=lambda r: r[f"rank_{primary}"]),
       "recommendation": [r["slug"] for r in cand], "best_below_threshold": [r["slug"] for r in below[:3]]}
json.dump(out, open("data/rankings.json", "w"), indent=1, ensure_ascii=False)
with open("data/rankings.csv", "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(out["rows"][0].keys())); w.writeheader(); w.writerows(out["rows"])
for r in out["rows"]:
    print(f'{r[f"rank_{primary}"]:>2} {r["party_en"][:38]:38} A={r["a"]:5} B={r["b"]} C={r[primary]} seats={r["polled_seats"]} {"EXCL" if r["excluded"] else ""}')
