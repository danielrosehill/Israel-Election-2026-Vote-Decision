#import "../style.typ": *

#section("What I said", kicker: "Stage 1 · the voice note", icon-name: "mic")

I recorded the note on 26 October 2026, looking out at the Knesset building. The full transcript, with only the disfluencies removed, is *Appendix A*. These are the lines the rubric was built on (times refer to the original recording).

#let quote-card(t, q, tag) = block(breakable: false, width: 100%, inset: (x: 12pt, y: 9pt), fill: paper, radius: 4pt, below: 7pt)[
  #grid(columns: (1fr, auto), gutter: 10pt,
    text(10.5pt, style: "italic")["#q"],
    align(right, [#text(8pt, fill: teal, weight: "bold", t) \ #text(7.5pt, fill: muted, tag)]))
]
#quote-card("03:26", "There's one rotten root to it, which is that in the way this country is set up, our electoral system, there is no accountability baked into the system.", "A6 accountability")
#quote-card("06:48", "Hopefully Netanyahu will not be elected. That's the one person I'm for sure not voting for.", "B3 Netanyahu")
#quote-card("07:25", "The biggest issue in my life, and it's not even close, is an issue that last time I checked, not a single major party running in this election had bothered to articulate any serious policy for. And that is tenant protection law.", "A1 tenant protection")
#quote-card("15:03", "The cost of living and the rest of it is such that getting on the property ladder is near impossible.", "A2 housing")
#quote-card("19:33", "Do I think that the Haredim, the ultra-religious, should serve in the army? Yes. I think the social contract can't exist like this.", "B1 Haredi enlistment")
#quote-card("22:22", "The cost of living. No one seems to be doing anything about it … Everything here is overpriced.", "A3 cost of living")
#quote-card("34:56", "I think the best answer to antisemitism and anti-Israelism is to make Israel great.", "A5 reputation · B9")
#quote-card("41:25", "This is our programme. It's free, it's consultative, it's democratic. We welcome participation. We're here to serve you.", "the party I'm looking for")
