# Research brief (for the party research agents)

Goal: for each assigned list running in the 27 October 2026 Knesset election, gather **evidence**
(not scores) of its positions on each criterion in `docs/rubric.md` (A1–A6, B1–B9). Scoring is
done afterwards, in one pass, by a different agent, so record what the party says and does, with
sources, and do not grade.

Party list source: `data/parties.csv` (copy of HF dataset
`danielrosehill/Israel-Election-2026-Candidate-Lists`, CEC lists as of the 2026 filing).

## Output: one file per list, `research/parties/<slug>.md`

```
# <party_en> (<party_he>, ballot letters <x>)
Leader: … | Components: … | Polled seats (10–22 Oct mean): … | Researched: 2026-10-27 by <agent/model>

## Platform availability (A6)
Published platform? URL, format (PDF/web), languages (Hebrew/Arabic/English/Russian/Amharic…), date. Costed? Consultative mechanisms? Electoral-reform or accountability proposals?

## A1 Tenant protection … ## A5 Global reputation
## B1 Haredi enlistment … ## B9 Diaspora / hasbara spending
(For each: what the party/leader has stated or done, 1–4 bullets, each with a [n] source ref and date.
If nothing found after a real search, write "No evidence found (searched: …)".)

## How the party presents itself
One short paragraph: what is its stated reason to exist? (Daniel's meta guide: programme-led vs anti-X / leader-grievance.)

## Sources
[n] title — publisher — URL — date accessed
```

Rules:
- Prefer primary sources (party platform, party site, leader statements, Knesset voting record of
  the party's MKs) then reputable press (Times of Israel, Haaretz, Ynet, Globes, The Marker, Calcalist,
  JPost, Israel Democracy Institute election guides). Hebrew sources are fine; quote in Hebrew with an English gloss.
- Label **confirmed** (source says it) vs **inferred** (from voting record, alliances, components).
- Past records count: e.g. a party's ministers' housing/cost-of-living record in the 2022–2026 government.
- Web route order: WebSearch/WebFetch first. If a JS site or `.co.il` blocks, try
  `mcp__gateway__toolbox__call_tool` with the `browser-personal__*` tools (agent browser), then curl.
  Note any route that failed.
- Be efficient: today is election day. Spend ~10–25 searches per major list; for minor lists 2–5
  searches each is enough (most have no platform; say so).
- Do not edit any file outside `research/parties/`. Do not commit.
