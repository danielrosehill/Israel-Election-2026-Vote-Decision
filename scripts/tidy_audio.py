"""Tidy a voice note using AssemblyAI word timestamps (disfluencies:true run).
Cuts: filler words, the first copy of immediate stutter repeats (1-4 words), pauses > MAXGAP (shortened to KEEPGAP).
Usage: tidy_audio.py <transcript.json> <in.wav> <out.wav> <cuts.json>"""
import json, re, sys
import numpy as np, soundfile as sf

FILLERS = {"um", "uh", "uhm", "er", "ah", "hmm", "mm", "erm"}
EMPHATIC = {"very", "really", "much", "radically", "why", "no", "yeah", "okay", "so", "more"}
MAXGAP, KEEPGAP, PAD, FADE = 0.70, 0.35, 0.06, 0.008

tj, wav_in, wav_out, cuts_out = sys.argv[1:5]
words = json.load(open(tj))["words"]
norm = [re.sub(r"[^a-z0-9']", "", w["text"].lower()) for w in words]
drop = [n in FILLERS for n in norm]
reason = ["filler" if d else "" for d in drop]

# Immediate repeats, ignoring fillers between them: remove the first copy.
idx = [i for i in range(len(words)) if not drop[i]]
k = 0
while k < len(idx):
    hit = False
    for n in (4, 3, 2, 1):
        a = [norm[i] for i in idx[k:k + n]]
        b = [norm[i] for i in idx[k + n:k + 2 * n]]
        if len(b) == n and a == b and all(a) and not (n == 1 and a[0] in EMPHATIC):
            for i in idx[k:k + n]:
                drop[i], reason[i] = True, f"repeat-{n}"
            k += n
            hit = True
            break
    if not hit:
        k += 1

audio, sr = sf.read(wav_in)
dur = len(audio) / sr
kept = [w for w, d in zip(words, drop) if not d]
segs = []  # [start_s, end_s]
for j, w in enumerate(kept):
    s, e = w["start"] / 1000, w["end"] / 1000
    if segs and s - segs[-1][1] <= MAXGAP and not any(drop[i] for i in range(words.index(kept[j - 1]) + 1, words.index(w))):
        segs[-1][1] = e
    else:
        segs.append([s, e])
# Pad each segment into its surrounding silence so the result keeps KEEPGAP between segments.
out = [[max(0, segs[0][0] - PAD), segs[0][1]]]
for s, e in segs[1:]:
    gap = s - out[-1][1]
    give = min(gap, KEEPGAP) / 2
    out[-1][1] += give
    out.append([s - give, e])
out[-1][1] = min(dur, out[-1][1] + PAD)

f = int(FADE * sr)
ramp = np.linspace(0, 1, f)
pieces = []
for s, e in out:
    p = audio[int(s * sr):int(e * sr)].copy()
    if len(p) > 2 * f:
        p[:f] *= ramp[:, None] if p.ndim > 1 else ramp
        p[-f:] *= ramp[::-1, None] if p.ndim > 1 else ramp[::-1]
    pieces.append(p)
res = np.concatenate(pieces)
sf.write(wav_out, res, sr)
cuts = [{"i": i, "word": words[i]["text"], "start_ms": words[i]["start"], "reason": reason[i]} for i in range(len(words)) if drop[i]]
stats = {"duration_before_s": round(dur, 1), "duration_after_s": round(len(res) / sr, 1),
         "segments": len(out), "words_cut": len(cuts),
         "by_reason": {r: sum(c["reason"] == r for c in cuts) for r in sorted({c["reason"] for c in cuts})},
         "params": {"max_gap_s": MAXGAP, "kept_gap_s": KEEPGAP, "fade_s": FADE}}
json.dump({"stats": stats, "cuts": cuts}, open(cuts_out, "w"), indent=1)
print(json.dumps(stats))
