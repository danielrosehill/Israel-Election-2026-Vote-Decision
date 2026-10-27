#import "../style.typ": *
#import "data.typ": *

#section("The result", kicker: "At a glance", icon-name: "trophy")

On the rubric built from my voice note, these are the three best matches among lists polling above the electoral threshold. They keep the same order whether everyday issues count for 70%, 50% or 100% of the score.

#v(4pt)
#grid(columns: (1fr, 1fr, 1fr), gutter: 10pt,
  ..rec.slice(0, 3).enumerate().map(((i, r)) => block(width: 100%, stroke: 1.2pt + (navy, teal, teal).at(i), radius: 6pt, inset: 10pt, fill: if i == 0 { navy.lighten(94%) } else { white })[
    #set align(center)
    #text(8.5pt, fill: muted, weight: "semibold")[CHOICE #(i + 1)] \
    #v(2pt)
    #he(letters-of(r.party_en), size: 34pt) \
    #v(2pt)
    #text(11pt, weight: "bold", fill: navy, r.party_en) \
    #text(8.5pt, fill: muted, r.leader) \
    #v(4pt)
    #text(20pt, weight: "bold", fill: teal)[#r.combined_70] #text(8pt, fill: muted)[out of 100]
    #v(-2pt)
    #text(8pt, fill: muted)[everyday #r.a · national #r.b]
  ]))
#text(8pt, fill: muted)[Hebrew letters are the ballot-slip letters from the Central Elections Committee candidate lists (my Hugging Face dataset). Check them against the slips in the booth.]

#callout(title: "The headline finding is a gap", color: amber, icon-name: "triangle-alert")[
  No list on the ballot has a real tenant-protection policy, which is my top issue. The best score on it is *3 out of 5* (Together, for tax incentives on leases of five years or more). Nobody proposes limits on no-cause or retaliatory eviction, or enforcement of repair duties or of the agent-fee ban. In the note I said "not a single major party … had bothered to articulate any serious policy for" it (07:25), and that is still true on election day.
]

== The top five, and why
#let why = (
  "together-bennett": [The strongest everyday offer: the most detailed cost-of-living plan (import and tariff liberalisation with price targets), 100,000 long-term rental units, and the only measure aimed at lease length. Weaker than the Democrats on national issues (Bennett's annexation stance), and its identity is partly "replace Netanyahu".],
  "democrats": [The closest match on almost every national issue, the best-documented programme (a 16-page platform PDF), and the only real plan on Israel's reputation. On rent it diagnoses the problem but offers only more public and long-term rental. On prices it leans on controls rather than competition.],
  "yisrael-beiteinu": [Concrete rental-supply and mortgage numbers, and strong on competition (ending exclusive importers) and on religion and state. Nothing on tenant protection, services or reputation, and it leads with the Haredi draft, the "same story" framing.],
  "joint-list": [The only rent cap of any major list (20% of household income) and a published socio-economic programme in Hebrew and Arabic. Its trade protectionism and its security positions are far from mine.],
  "yashar": [Polls second overall and fits me on national issues, but on everyday issues it offers one undetailed phrase on renters. It leads with the October 7 commission and its leader's name: the ex-general's-party pattern from the note.],
)
#for (i, r) in rec.slice(0, 5).enumerate() {
  block(breakable: false, above: 8pt, below: 8pt, grid(columns: (28pt, 46pt, 1fr, 70pt), gutter: 8pt, align: (center + horizon, center + horizon, left + horizon, right + horizon),
    box(width: 22pt, height: 22pt, radius: 11pt, fill: if i < 3 { navy } else { muted }, align(center + horizon, text(fill: white, weight: "bold")[#(i + 1)])),
    he(letters-of(r.party_en), size: 17pt),
    [*#r.party_en* #text(fill: muted, size: 8.5pt)[· #r.leader · polled #seats(r.polled_seats) seats] \ #text(9pt, why.at(r.slug, default: []))],
    [#text(15pt, weight: "bold", fill: teal)[#r.combined_70] \ #bar(r.combined_70, width: 60pt)]))
}

#callout(title: "Excluded by my own rule", color: red, icon-name: "info")[
  Netanyahu is "the one person I'm for sure not voting for" (06:48). Lists running him for PM, or pledged to recommend only him, are scored but never recommended: #rows.filter(r => r.excluded).map(r => r.party_en).join(", "). The best match below the threshold is #rowof(rk.best_below_threshold.first()).party_en (about #seats(rowof(rk.best_below_threshold.first()).polled_seats) seats in recent polls).
]
