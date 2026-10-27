#import "../style.typ": *
#import "data.typ": *
= Recommendations by match
#md("/report/parts/findings.md")

== Lists that pass the threshold, best match first
_Combined score = 0.7 × Stream A + 0.3 × Stream B (0–100). Lists running or pledged to recommend only Netanyahu are excluded by Daniel's stated choice and not shown here. Polled seats: mean of polls released 10–22 Oct 2026._
#{
  let rec = rk.recommendation.map(s => rowof(s))
  table(columns: (auto, 1fr, auto, auto, auto, auto, auto, auto),
    table.header([*\#*], [*List*], [*Ballot*], [*Combined 70/30*], [*Combined 50/50*], [*Stream A*], [*Stream B*], [*Polled seats*]),
    ..rec.enumerate().map(((i, r)) => (
      [#(i + 1)], [*#r.party_en* \ #text(fill: gray)[#r.leader]], letters(r.party_en),
      pct(r.combined_70), pct(r.combined_50), pct(r.a), pct(r.b), [#seats(r.polled_seats)])).flatten())
}
#if rk.best_below_threshold.len() > 0 [
  == Best matches polling below the threshold
  _A vote here is likely to be lost unless the list crosses 3.25% (about 4 seats)._
  #table(columns: (1fr, auto, auto, auto, auto),
    table.header([*List*], [*Combined 70/30*], [*Stream A*], [*Stream B*], [*Polled seats*]),
    ..rk.best_below_threshold.map(s => rowof(s)).map(r => ([*#r.party_en*], pct(r.combined_70), pct(r.a), pct(r.b), [#seats(r.polled_seats)])).flatten())
]
