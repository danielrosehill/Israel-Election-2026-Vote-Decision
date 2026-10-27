# CLAUDE.md

Daniel's personal vote-decision project for the 27 October 2026 Knesset election. Public repo by design (including the audio). Source of truth, in order: the voice note (`context/voice-notes/2026-10-26-politics/`, edited transcript for reading, raw for quoting), then `docs/rubric.md`, then `research/parties/` evidence, then `data/scores.json`.

## Layout
- `context/voice-notes/2026-10-26-politics/`: tidied audio, raw / disfluencies-removed / edited transcripts, `audio-cuts.json`, `processing.json`. The original recording is not committed (Daniel chose the tidied one, 2026-10-27).
- `docs/rubric.md` + `docs/rubric.json`: criteria, weights, Daniel's stated positions with note timestamps.
- `research/BRIEF.md`: instructions the research agents followed. `research/parties/*.md`: evidence per list (not scores).
- `data/`: `parties.csv` (HF candidate-lists dataset copy), polls snapshot, `scores.json` (per-criterion 0–5 with reasons), `rankings.json/csv` (from `scripts/rank.py`).
- `scripts/tidy_audio.py`: the audio tidy (AssemblyAI word timestamps). `scripts/rank.py`: scores → rankings.
- `report/`: Typst sources; PDFs in `output/`.
- `space/`: static HF Space (public, `danielrosehill/Israel-Election-2026-AI-Vote-Decision`); `space/data.json` is built from `data/scores.json` + `data/rankings.json` + `report/parts/findings.md`. Publish: `with-secrets uv run --with huggingface_hub python3 -I scripts/publish_space.py`.
- Podcast: My Weird Prompts job `custom-bf7d47e5` (2026-10-27), methodology + top five; prior related episode #6065.

## Rules
- Timestamps everywhere refer to the ORIGINAL recording's timeline, not the tidied audio.
- Never edit `transcript-raw.txt`.
- Scores must cite evidence in `research/parties/`; mark inferred vs confirmed.
- Blue and White withdrew on 2026-10-19 (not on the ballot); keep it out of rankings.
