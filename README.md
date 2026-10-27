# Israel Election 2026: Vote Decision

Working out who to vote for in the election to Israel's 26th Knesset (27 October 2026), starting from a 42-minute voice note in which I set out what I think is broken in Israeli politics and what I care about. The note defines the research task: build a rubric from my priorities, score every list on the ballot, rank them, and recommend.

**Status (2026-10-27):** done. Best match: **Together (Bennett–Lapid, ballot רק)**, then **The Democrats (אמת)**, then **Yisrael Beiteinu (ל)**. No list on the ballot has a real tenant-protection policy, my top issue.

## Reports

**Start here: [End to end (PDF)](output/end-to-end.pdf)**: the result, the process stage by stage, what I said, the rubric and weights, charts, party profiles, limits, and the voice-note transcript as Appendix A.

- [Analysis (PDF)](output/analysis.pdf): recommendations, rankings, the full score matrix, party profiles, method
- [Transcripts (PDF)](output/transcripts.pdf): edited and raw transcripts
- [Interactive version (HF Space)](https://huggingface.co/spaces/danielrosehill/Israel-Election-2026-AI-Vote-Decision): move the weights, watch the ranking change

## Project brief

| | |
|---|---|
| Audio (tidied: fillers, stutters and long pauses cut, 35:15) | [voice-note-tidied.mp3](context/voice-notes/2026-10-26-politics/voice-note-tidied.mp3) |
| Raw transcript (AssemblyAI, unedited) | [transcript-raw.txt](context/voice-notes/2026-10-26-politics/transcript-raw.txt) |
| Disfluencies removed (wording and order unchanged, timestamped) | [transcript-disfluencies-removed.md](context/voice-notes/2026-10-26-politics/transcript-disfluencies-removed.md) |
| Edited (false starts and repetition removed, sectioned) | [transcript-edited.md](context/voice-notes/2026-10-26-politics/transcript-edited.md) |
| Every audio cut, with reason | [audio-cuts.json](context/voice-notes/2026-10-26-politics/audio-cuts.json) |
| Provenance | [processing.json](context/voice-notes/2026-10-26-politics/processing.json) |

Recorded 2026-10-26. In the recording I say "28th October"; that was a slip, corrected in the edited transcripts.

## Method

Attribution: voice note and priorities by me. Rubric, criteria and weighting assignment by Claude Opus 5.5 (`claude-opus-5-5`, Anthropic) on 27 October 2026. Party research by Claude Sonnet agents, and scoring by Claude Opus 5.5, the same day. Transcription by AssemblyAI.


- Rubric: [docs/rubric.md](docs/rubric.md) (machine copy `docs/rubric.json`). Stream A = everyday pain points (tenant protection, housing, cost of living, a working state, Israel's reputation, programme quality); Stream B = the divisive national issues.
- Party lists: `data/parties.csv`, from the Hugging Face dataset [Israel-Election-2026-Candidate-Lists](https://huggingface.co/datasets/danielrosehill/Israel-Election-2026-Candidate-Lists). Polls: `data/polls-2026-10-10_to_22.csv`, from [Israel-Election-2026-Polls](https://huggingface.co/datasets/danielrosehill/Israel-Election-2026-Polls).
- Evidence per party: `research/parties/` (brief: `research/BRIEF.md`). Scores: `data/scores.json`; rankings: `scripts/rank.py` → `data/rankings.json`.
- Rebuild the PDFs: `cd report && typst compile --root .. --font-path fonts end-to-end.typ ../output/end-to-end.pdf` (same for `analysis`, `transcripts`). Shared stylesheet `report/style.typ`; fonts IBM Plex Sans + Alef (OFL, bundled in `report/fonts/`); icons Lucide (ISC, `report/icons/`).
