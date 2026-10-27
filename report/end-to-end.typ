#import "style.typ": *
#import "parts/data.typ": *
#show: doc.with(title: "Who should I vote for?", kind: "End to end",
  subtitle: "Using AI to turn a voice note into a voting recommendation for Israel's 26th Knesset election, 27 October 2026",
  cover-extra: [
    #text(10.5pt)[On the eve of the election I recorded 42 minutes on what I think is broken in Israeli politics and what I care about as a voter. Claude turned that into a scoring rubric. Research agents gathered evidence on every list on the ballot, and each list was scored against my priorities. This document follows the whole run, from the voice note to the recommendation.]
    #v(14pt)
    #text(9pt, fill: muted, weight: "semibold")[BEST MATCHES, ABOVE THE THRESHOLD]
    #v(4pt)
    #grid(columns: (1fr, 1fr, 1fr), gutter: 10pt, ..rec.slice(0, 3).enumerate().map(((i, r)) => block(width: 100%, fill: paper, radius: 5pt, inset: 10pt)[
      #set align(center)
      #text(8pt, fill: muted)[#(i + 1)] \ #he(letters-of(r.party_en), size: 26pt) \ #text(9.5pt, weight: "bold", fill: navy, r.party_en) \ #text(8pt, fill: muted)[score #r.combined_70]]))
  ])
#contents()
#include "parts/result.typ"
#include "parts/process.typ"
#include "parts/voice.typ"
#include "parts/rubric.typ"
#include "parts/analysis.typ"
#include "parts/profiles.typ"
#include "parts/limits.typ"
#include "parts/appendix-a.typ"
