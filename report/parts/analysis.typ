#import "../style.typ": *
#import "data.typ": *
= Rankings
== Stream A only: everyday pain points
_Weighted 0–100: tenant protection 30, housing 20, cost of living 20, working state 15, reputation 10, programme quality 5._
#{
  let rs = rows.sorted(key: r => -r.a)
  table(columns: (auto, 1fr, ..A.map(_ => auto), auto, auto),
    table.header([*\#*], [*List*], ..A.map(k => [*#k*]), [*A score*], [*Seats*]),
    ..rs.enumerate().map(((i, r)) => {
      let s = byslug.at(r.slug).scores
      ([#(i + 1)], [#r.party_en#if r.excluded [ #text(fill: gray)[(excl.)]]], ..A.map(k => cell(s.at(k).score)), pct(r.a), [#seats(r.polled_seats)])
    }).flatten())
}
== Both streams
_Stream B = mean alignment on the scored B items × 20 (items with no evidence excluded; fewer than #rub.stream_b_min_items scored = insufficient). (excl.) = runs Netanyahu for PM or pledged to recommend only him; ranked but not recommendable._
#{
  let rs = rows.sorted(key: r => -(if r.combined_70 == none { -1 } else { r.combined_70 }))
  table(columns: (auto, 1fr, auto, auto, auto, auto, auto),
    table.header([*\#*], [*List*], [*A*], [*B*], [*70/30*], [*50/50*], [*Seats*]),
    ..rs.enumerate().map(((i, r)) => ([#(i + 1)], [#r.party_en#if r.excluded [ #text(fill: gray)[(excl.)]]], pct(r.a), pct(r.b), pct(r.combined_70), pct(r.combined_50), [#seats(r.polled_seats)])).flatten())
}
= Raw scores
_Every criterion 0–5. – = no evidence found (counts as 0 in Stream A, excluded from Stream B). Criteria: #rub.stream_a.map(c => [*#c.id* #c.name]).join("; "); #rub.stream_b.map(c => [*#c.id* #c.name]).join("; ")._
#{
  set text(7.5pt)
  let rs = rows.sorted(key: r => -r.a)
  table(columns: (1fr, ..(A + B).map(_ => auto)), inset: 3.5pt,
    table.header([*List*], ..(A + B).map(k => [*#k*])),
    ..rs.map(r => { let s = byslug.at(r.slug).scores; ([#r.party_en], ..(A + B).map(k => cell(s.at(k).score))) }).flatten())
}
= Party profiles
_Lists polling at or above the threshold, and the best matches below it. Full evidence with sources: `research/parties/` in the repo._
#for slug in rows.filter(r => r.viable or rk.best_below_threshold.contains(r.slug)).sorted(key: r => -(if r.combined_70 == none { -1 } else { r.combined_70 })).map(r => r.slug) {
  let p = byslug.at(slug)
  let r = rowof(slug)
  block(breakable: true, above: 1.4em)[
    == #p.party_en #if "party_he" in p and p.party_he != none [ #text(weight: "regular", size: 10pt)[(#p.party_he)]]
    #text(fill: gray)[#p.leader · polled seats #seats(r.polled_seats) · A #r.a · B #if r.b == none [–] else [#r.b] · combined #if r.combined_70 == none [–] else [#r.combined_70]#if r.excluded [ · excluded (Netanyahu)]]

    #p.summary
    #table(columns: (auto, auto, 1fr),
      ..(A + B).map(k => ([*#k*], cell(p.scores.at(k).score), [#p.scores.at(k).why#if p.scores.at(k).at("basis", default: "") == "inferred" [ _(inferred)_]])).flatten())
  ]
}
