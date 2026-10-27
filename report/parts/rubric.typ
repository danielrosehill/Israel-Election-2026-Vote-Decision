#import "../style.typ": *
#import "data.typ": *

#section("What I care about: the rubric", kicker: "Stage 3 · criteria and weights", icon-name: "scale")

#callout(title: "Who set the weights", icon-name: "sparkles")[The criteria and weights were assigned by *Claude Opus 5.5* on 27 October 2026, from the emphasis in my voice note. They are an inference, not something I dictated. The interactive version lets you change them.]

The rubric has two streams. *Stream A* covers the everyday pain points I put first. *Stream B* covers the divisive national issues, which I set "to one side" for the first ranking but did not ignore.

== Stream A · everyday pain points (weights out of 100)
#let a-icons = ("A1": "house", "A2": "landmark", "A3": "shopping-cart", "A4": "clipboard-list", "A5": "globe", "A6": "file-text")
#let a-pos = (
  "A1": [My biggest issue, "not even close". Retaliatory termination, tenancy at will, the unenforced three-day repair rule, illegal agent fees.],
  "A2": [The property ladder is "near impossible"; luxury and investment towers instead of homes for residents.],
  "A3": [Everything costs double or triple; an anti-competitive market; the personal-import limit was a petty own goal.],
  "A4": [Utilities and Arnona admin, small-business bureaucracy, urgent care that left our son unattended, shelters closed or charging for parking.],
  "A5": [International anger is "largely justified"; hasbara is not the answer.],
  "A6": [A published, coherent, consultative programme; transparency; accountability, ideally constituency representation.],
)
#table(columns: (18pt, 120pt, 1fr, 80pt), align: (center + horizon, left + horizon, left + horizon, left + horizon),
  table.header([], [Criterion], [My position], [Weight]),
  ..rub.stream_a.map(c => (icon(a-icons.at(c.id), size: 12pt, color: teal), [*#c.id* #c.name], text(8.5pt, a-pos.at(c.id)),
    [#box(width: 55pt, bar(c.weight, max: 30, height: 8pt)) #h(3pt) *#c.weight*])).flatten())

== Stream B · national issues (each 0–5 for alignment with me, equal weights)
#let b-pos = (
  "B1": [Yes, the Haredim should serve; no benefits without contribution. But leading with it is "the same story".],
  "B2": [The overhaul is "very, very dangerous, very erosive".],
  "B3": [Not voting for Netanyahu: the exclusion rule.],
  "B4": [Ben-Gvir and Smotrich are extremists the system relies on.],
  "B5": [Don't rule out a Palestinian state in principle; don't see a path to one.],
  "B6": [A strong Israel that forms alliances where possible.],
  "B7": [Against religious coercion, especially in Jerusalem.],
  "B8": [A state commission should exist, but it isn't front-line policy.],
  "B9": [Israel shouldn't appoint itself guardian of world Jewry or fund public diplomacy that "never really shows fruit".],
)
#table(columns: (138pt, 1fr), align: (left + horizon, left + horizon),
  table.header([Issue], [My position]),
  ..rub.stream_b.map(c => ([*#c.id* #c.name], text(8.5pt, b-pos.at(c.id)))).flatten())

== How the scores combine
#grid(columns: (1fr, 1fr, 1fr), gutter: 8pt,
  ..(("Stream A", "Σ weight × score/5, out of 100. No evidence counts as 0: a policy I can't find is no policy."),
     ("Stream B", "Mean alignment × 20, out of 100. No-evidence items are left out; at least 4 must be scored."),
     ("Combined", "0.7 × A + 0.3 × B (also run at 50/50). Only lists polling at least 4 seats (3.25%) are recommended.")).map(((t, d)) =>
    block(fill: paper, radius: 4pt, inset: 9pt, width: 100%, height: 62pt)[#text(fill: navy, weight: "bold", t) \ #text(8.5pt, d)]))
