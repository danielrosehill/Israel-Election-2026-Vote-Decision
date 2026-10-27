#import "../style.typ": *
#import "data.typ": *

#section("The analysis", kicker: "Stages 4–6 · research, scores, ranking", icon-name: "chart-bar-big")

All 37 lists on the ballot were scored (38 filed; Blue and White withdrew on 19 October). The charts below show where the score comes from, how the two streams pull against each other, and every individual score.

== Combined score: what each stream contributes
#text(8.5pt, fill: muted)[Each bar is 0.7 × Stream A (teal) plus 0.3 × Stream B (navy). Grey = excluded under my Netanyahu rule. #box(fill: amber.lighten(70%), inset: (x: 3pt), radius: 2pt)[below threshold] = polling under 4 seats. Lists with too little Stream B evidence for a combined score are left off this chart.]
#v(4pt)
#{
  let rs = ranked.filter(r => r.combined_70 != none)
  let W = 250pt
  grid(columns: (150pt, W, 40pt), row-gutter: 4.5pt, column-gutter: 6pt, align: (right + horizon, left + horizon, left + horizon),
    ..rs.map(r => {
      let ca = 0.7 * r.a / 100 * W
      let cb = 0.3 * r.b / 100 * W
      let (c1, c2) = if r.excluded { (luma(185), luma(150)) } else { (teal, navy) }
      (text(8.5pt, fill: if r.excluded { muted } else { ink })[#r.party_en#if not r.viable [ #box(fill: amber.lighten(70%), inset: (x: 2pt), radius: 2pt, text(7pt)[low])]],
       box(width: W, height: 11pt, fill: paper, radius: 2pt, stack(dir: ltr, box(width: ca, height: 11pt, fill: c1), box(width: cb, height: 11pt, fill: c2))),
       text(8.5pt, weight: "bold", fill: if r.excluded { muted } else { ink })[#r.combined_70])
    }).flatten())
}

#block(breakable: false)[
== Everyday issues vs national issues
#text(8.5pt, fill: muted)[Stream A (x) against Stream B (y), for every list with both scores. Top right is the best fit on both.]
#v(4pt)
#{
  let S = 300pt
  let pts = ranked.filter(r => r.b != none)
  let lbl = rk.recommendation.slice(0, 6)
  align(center, box(width: S + 40pt, height: S + 30pt, {
    place(dx: 30pt, dy: 0pt, box(width: S, height: S, fill: paper, stroke: 0.5pt + line-c, {
      for g in (25, 50, 75) {
        place(dx: g / 100 * S, dy: 0pt, line(angle: 90deg, length: S, stroke: 0.3pt + line-c))
        place(dx: 0pt, dy: S - g / 100 * S, line(length: S, stroke: 0.3pt + line-c))
      }
      for r in pts {
        let x = r.a / 100 * S
        let y = S - r.b / 100 * S
        let c = if r.excluded { luma(160) } else if r.viable { teal } else { amber }
        place(dx: x - 4pt, dy: y - 4pt, circle(radius: 4pt, fill: c, stroke: 0.6pt + white))
        if lbl.contains(r.slug) or r.excluded and r.viable {
          place(dx: x + 6pt, dy: y - 5pt, text(7pt, fill: if r.excluded { muted } else { navy }, weight: "semibold", r.party_en.split(" (").first()))
        }
      }
    }))
    for g in (0, 50, 100) {
      place(dx: 30pt + g / 100 * S - 6pt, dy: S + 4pt, text(7pt, fill: muted)[#g])
      place(dx: 14pt, dy: S - g / 100 * S - 4pt, text(7pt, fill: muted)[#g])
    }
    place(dx: 30pt + S / 2 - 50pt, dy: S + 16pt, text(8pt, fill: muted)[Stream A: everyday issues →])
    place(dx: 0pt, dy: S / 2 + 50pt, rotate(-90deg, origin: top + left, text(8pt, fill: muted)[Stream B: national issues →]))
  }))
  align(center, text(8pt, fill: muted)[#box(circle(radius: 3pt, fill: teal)) above threshold #h(8pt) #box(circle(radius: 3pt, fill: amber)) below threshold #h(8pt) #box(circle(radius: 3pt, fill: luma(160))) excluded (Netanyahu)])
}
]

#pagebreak(weak: true)
== Every score, every list
#text(8.5pt, fill: muted)[0–5 per criterion, sorted by Stream A. – = no evidence found (counts as 0 in Stream A, left out of Stream B). Criteria: #(rub.stream_a + rub.stream_b).map(c => [*#c.id* #c.name]).join("; ").]
#{
  set text(7.2pt)
  let rs = rows.sorted(key: r => -r.a)
  table(columns: (1fr, ..(A + B).map(_ => 17pt), 24pt, 24pt), inset: (x: 2pt, y: 3pt), stroke: 0.4pt + white,
    table.header([List], ..(A + B).map(k => align(center)[#k]), [A], [B]),
    ..rs.map(r => { let s = byslug.at(r.slug).scores
      ([#text(fill: if r.excluded { muted } else { ink }, r.party_en)], ..(A + B).map(k => cell(s.at(k).score)), pct(r.a), pct(r.b)) }).flatten())
}

#pagebreak(weak: true)
== Full ranking
#{
  table(columns: (auto, 1fr, auto, auto, auto, auto, auto, auto), align: (center, left, center, center, center, center, center, center),
    table.header([\#], [List], [Ballot], [A], [B], [70/30], [50/50], [Seats]),
    ..ranked.enumerate().map(((i, r)) => ([#(i + 1)], [#r.party_en#if r.excluded [ #text(fill: red, size: 7pt)[excluded]]],
      he(letters-of(r.party_en), size: 10pt), pct(r.a), pct(r.b), pct(r.combined_70), pct(r.combined_50), [#seats(r.polled_seats)])).flatten())
  text(8pt, fill: muted)[Lists with fewer than #rub.stream_b_min_items scored Stream B items have no combined score and are ordered by 0.7 × A. Seats: mean of polls released 10–22 October 2026.]
}
