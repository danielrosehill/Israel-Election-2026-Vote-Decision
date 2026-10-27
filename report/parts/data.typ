#let rub = json("/docs/rubric.json")
#let sc = json("/data/scores.json")
#let rk = json("/data/rankings.json")
#let A = rub.stream_a.map(c => c.id)
#let B = rub.stream_b.map(c => c.id)
#let byslug = (:)
#for p in sc.parties { byslug.insert(p.slug, p) }
#let rows = rk.rows
#let rowof(slug) = rows.find(r => r.slug == slug)
#let seats(v) = if v == none or v == 0 [–] else [#calc.round(v, digits: 1)]
#let pcsv = csv("/data/parties.csv", row-type: dictionary)
#let letters(name) = { let m = pcsv.find(x => x.party_en == name); if m == none [–] else { text(font: "IBM Plex Sans Hebrew", weight: "bold", m.ballot_letters) } }
