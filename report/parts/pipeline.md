This document runs the whole project end to end, on election day, 27 October 2026.

1. **Voice note (26 October 2026, 42 min).** I recorded what I think is broken in Israeli politics and what I care about, and set the research task: build an objective rubric from my priorities, score every list on the ballot, rank them, and recommend.
2. **Transcription.** AssemblyAI (universal model), raw transcript kept unedited. Two cleaned versions: disfluencies removed, and lightly edited (false starts and repetition removed, sectioned, mishearings corrected and listed).
3. **Audio.** The committed audio is tidied using the word timestamps: 313 filler and stutter words and every pause over 0.7 s cut (42:28 → 35:15). Nothing else is changed. Every cut is logged in `audio-cuts.json`.
4. **Rubric.** Derived from the note, with each position cited to its timestamp. Stream A covers the everyday pain points; Stream B covers the divisive national issues.
5. **Research.** Four agents gathered sourced evidence on every list (38 filed; Blue and White withdrew on 19 October), from party platforms, party sites, the Israel Democracy Institute and the press. Lists come from my Hugging Face dataset of the CEC candidate lists.
6. **Scoring and ranking.** One agent scored all lists on all 15 criteria from that evidence. `scripts/rank.py` computes Stream A, Stream B and combined scores, checks them against the polls, and produces the recommendation.

Repo: github.com/danielrosehill/Israel-Election-2026-Vote-Decision
