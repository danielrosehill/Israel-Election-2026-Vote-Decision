#import "../style.typ": *

#section("How it was done", kicker: "The process, end to end", icon-name: "list-checks")

The whole run happened on election day, 27 October 2026. It went from a voice note recorded the evening before to a recommendation, through six stages. Each stage's output is in the repository, so every step can be checked.

#let stages = (
  ("mic", "Voice note", "Daniel · 26 October 2026", [A 42-minute note on what I think is broken in Israeli politics and what I care about as a voter. It ends with the research task.], "context/voice-notes/2026-10-26-politics/"),
  ("audio-lines", "Transcription and audio tidy", "AssemblyAI universal model · Claude Opus 5.5", [Raw transcript kept unedited, plus a disfluency-free version (Appendix A) and a lightly edited one. The audio was tidied from the word timestamps: 313 filler and stutter words and every pause over 0.7 s cut, taking it from 42:28 to 35:15.], "transcript-*.md, voice-note-tidied.mp3"),
  ("scale", "Rubric and weights", "Claude Opus 5.5 · 27 October 2026", [My positions extracted from the note, each cited to its timestamp, turned into 15 criteria in two streams. The weights were assigned by Claude from the note's emphasis.], "docs/rubric.md"),
  ("search", "Research", "Four Claude Sonnet agents, in parallel", [Sourced evidence on all 38 filed lists, from party platforms and sites, the Israel Democracy Institute and the press, each claim marked confirmed or inferred. One thin pass (the right bloc) was sent back for a deeper second pass.], "research/parties/"),
  ("clipboard-list", "Scoring", "One Claude Opus agent, single pass", [Every list scored 0–5 on all 15 criteria from that evidence, with a written reason for each score, so all lists are graded against the same reading of the rubric.], "data/scores.json"),
  ("chart-bar-big", "Ranking and report", "scripts/rank.py · Typst", [Stream scores combined, my exclusion rule applied, the result checked against the polls, and the result typeset as this document.], "data/rankings.json, output/*.pdf"),
)
#grid(columns: (34pt, 1fr), column-gutter: 10pt, row-gutter: 12pt,
  ..stages.enumerate().map(((i, st)) => {
    let (ic, title, who, what, out) = st
    (box(width: 30pt, height: 30pt, radius: 15pt, fill: navy, align(center + horizon, icon(ic, size: 15pt, color: white))),
     block(stroke: (left: 1.5pt + line-c), inset: (left: 10pt, y: 2pt))[#text(8pt, fill: teal, weight: "bold")[STAGE #(i + 1)] #h(4pt) #text(11pt, weight: "bold", fill: navy, title) \
       #text(8.5pt, fill: muted)[#icon("sparkles", size: 8pt, color: muted) #who] \
       #text(9.5pt, what) \
       #text(8pt, fill: muted)[Output: #raw(out)]])
  }).flatten())

#v(10pt)
#block(breakable: false)[
== Attribution
#table(columns: (auto, 1fr), stroke: none,
  table.header([Role], [Who / what]),
  [Voice note, priorities, final decision], [Daniel Rosehill],
  [Rubric, criteria and *weighting assignment*], [Claude Opus 5.5 (`claude-opus-5-5`), Anthropic, 27 October 2026, from the voice note],
  [Party research], [Claude Sonnet agents, 27 October 2026, brief in `research/BRIEF.md`],
  [Scoring], [Claude Opus 5.5, one pass, 27 October 2026],
  [Transcription], [AssemblyAI universal model (transcript id `c2ba33df-42da-45d1-8946-c62f9a74e51b`)],
  [Data], [Candidate lists and polls from my Hugging Face datasets `Israel-Election-2026-Candidate-Lists` and `Israel-Election-2026-Polls`],
  [Typesetting], [Typst, IBM Plex Sans, Alef (Hebrew), Lucide icons],
)
]
