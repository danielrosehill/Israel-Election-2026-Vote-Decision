#import "../style.typ": *

#section("Limits and how to read this", kicker: "Caveats", icon-name: "triangle-alert", color: amber.darken(10%))

#callout(title: "This is one voter's fit, not a rating of the parties", color: amber, icon-name: "info")[Every score measures alignment with the positions in my voice note. A party can be serious, competent and well run and still score low here because it is aiming at a different voter.]

- *The weights are an inference.* Claude Opus 5.5 assigned them from the emphasis in a 42-minute monologue. The top three hold at 70/30, 50/50 and on Stream A alone, but other weightings can change the order lower down. The interactive version lets you test that.
- *Missing evidence scores as zero on everyday issues.* That is deliberate (a policy I can't find is no policy), but it punishes lists with poor websites as well as lists with no ideas.
- *The research was done in a day, by agents.* Several party sites refused automated access and some PDFs were image-only. The 22 minor lists got 2–5 searches each. The first pass on the right bloc was too thin and had to be redone.
- *One scorer.* A single agent scored every list for consistency. That makes the scores comparable, but no second reader checked them. Every score has a written reason, in the profiles and in `data/scores.json`.
- *Inferred items.* Some Stream B scores rest on a list's record or alliances rather than a stated position; these are marked _(inferred)_. Ra'am reached a combined score only because one such item was inferred.
- *Polls are a snapshot.* Viability uses the mean of polls released 10–22 October 2026, not the result.

== Where everything is
#table(columns: (auto, 1fr), stroke: none,
  table.header([What], [Where in the repository]),
  [Tidied audio and all transcripts], [`context/voice-notes/2026-10-26-politics/`],
  [Rubric (human and machine)], [`docs/rubric.md`, `docs/rubric.json`],
  [Research brief and evidence per list], [`research/BRIEF.md`, `research/parties/`],
  [Scores with reasons; rankings], [`data/scores.json`; `data/rankings.json` from `scripts/rank.py`],
  [Interactive version], [#link("https://huggingface.co/spaces/danielrosehill/Israel-Election-2026-AI-Vote-Decision")[huggingface.co/spaces/danielrosehill/Israel-Election-2026-AI-Vote-Decision]],
)
