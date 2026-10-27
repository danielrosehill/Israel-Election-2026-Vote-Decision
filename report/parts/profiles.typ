#import "../style.typ": *
#import "data.typ": *

#section("Party profiles", kicker: "The evidence behind the scores", icon-name: "users")

Lists polling above the threshold, plus the best matches below it, in order of combined score. Each score has the reason the scoring agent gave. _(inferred)_ marks a score based on the list's record or alliances rather than a stated position. Full evidence with sources is in `research/parties/`.

#for r in ranked.filter(r => r.viable or rk.best_below_threshold.contains(r.slug)) {
  let p = byslug.at(r.slug)
  let col = if r.excluded { muted } else if r.viable { navy } else { amber }
  block(breakable: true, above: 14pt, width: 100%, stroke: 0.6pt + line-c, radius: 5pt, clip: true)[
    #block(width: 100%, fill: col, inset: (x: 12pt, y: 8pt), below: 0pt)[
      #set text(fill: white)
      #grid(columns: (auto, 1fr, auto), gutter: 10pt, align: horizon,
        he(letters-of(r.party_en), size: 20pt),
        [#show heading: it => text(12pt, weight: "bold", fill: white, it.body)
         #heading(level: 2, outlined: true, r.party_en) \ #text(8.5pt)[#r.leader · polled #seats(r.polled_seats) seats#if r.excluded [ · excluded: Netanyahu rule]]],
        align(right)[#text(18pt, weight: "bold")[#if r.combined_70 == none [–] else [#r.combined_70]] \ #text(7.5pt)[A #r.a · B #if r.b == none [–] else [#r.b]]])
    ]
    #block(inset: (x: 12pt, y: 9pt))[
      #text(9.5pt, p.summary)
      #v(2pt)
      #table(columns: (22pt, 120pt, 20pt, 1fr), inset: (x: 4pt, y: 3.5pt), align: (left + horizon, left + horizon, center + horizon, left + horizon),
        ..(A + B).map(k => ([*#k*], text(fill: muted, names.at(k)), cell(p.scores.at(k).score),
          [#p.scores.at(k).why#if p.scores.at(k).at("basis", default: "") == "inferred" [ _(inferred)_]])).flatten())
    ]
  ]
}
