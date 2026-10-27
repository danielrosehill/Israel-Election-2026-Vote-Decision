#let rub = json("/docs/rubric.json")
#let sc = json("/data/scores.json")
#let rk = json("/data/rankings.json")
#let A = rub.stream_a.map(c => c.id)
#let B = rub.stream_b.map(c => c.id)
#let names = (:)
#for c in rub.stream_a + rub.stream_b { names.insert(c.id, c.name) }
#let byslug = (:)
#for p in sc.parties { byslug.insert(p.slug, p) }
#let rows = rk.rows
#let rowof(slug) = rows.find(r => r.slug == slug)
#let seats(v) = if v == none or v == 0 [–] else [#calc.round(v, digits: 1)]
#let pcsv = csv("/data/parties.csv", row-type: dictionary)
#let letters-of(name) = { let m = pcsv.find(x => x.party_en == name); if m == none { "" } else { m.ballot_letters } }
#let rec = rk.recommendation.map(s => rowof(s))
#let ckey(r) = if r.combined_70 == none { 0.7 * r.a } else { r.combined_70 }
#let ranked = rows.sorted(key: r => -ckey(r))
