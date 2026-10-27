#import "@preview/cmarker:0.1.6"

#let accent = rgb("#1f4e79")
#let md(path) = cmarker.render(read(path), h1-level: 2)

#let doc(title: "", subtitle: "", body) = {
  set document(title: title, author: "Daniel Rosehill")
  set page(paper: "a4", margin: (x: 2cm, y: 2.2cm),
    header: context { if counter(page).get().first() > 1 [#set text(8pt, fill: gray); #title #h(1fr) 27 October 2026] },
    footer: context [#set text(8pt, fill: gray); #h(1fr) #counter(page).display() #h(1fr)])
  set text(font: ("IBM Plex Sans", "IBM Plex Sans Hebrew", "IBM Plex Sans Arabic"), size: 10pt, lang: "en")
  set par(justify: true, leading: 0.62em)
  set heading(numbering: none)
  show heading.where(level: 1): it => { pagebreak(weak: true); set text(18pt, fill: accent, weight: "semibold"); block(below: 1em, it.body) }
  show heading.where(level: 2): set text(13pt, fill: accent, weight: "semibold")
  show heading.where(level: 3): set text(11pt, weight: "semibold")
  show link: set text(fill: accent)
  set table(stroke: 0.4pt + luma(200), inset: 5pt)
  show table: set text(8.5pt)
  show table: set par(justify: false)
  // Cover
  align(left + horizon)[
    #text(24pt, weight: "bold", fill: accent, title) \
    #v(0.4em)
    #text(13pt, subtitle) \
    #v(1.5em)
    #text(10pt, fill: gray)[Daniel Rosehill · prepared with Claude (Anthropic, claude-opus-5-5) · 27 October 2026 \
    github.com/danielrosehill/Israel-Election-2026-Vote-Decision]
  ]
  pagebreak()
  body
}

// Score cell: 0-5 (or none) shaded from red to green.
#let shade(v, max: 5) = if v == none { luma(235) } else { color.mix((rgb("#d9534f"), max - v), (rgb("#5cb85c"), v)).lighten(45%) }
#let cell(v, max: 5) = table.cell(fill: shade(v, max: max), align: center)[#if v == none [–] else [#v]]
#let pct(v) = table.cell(fill: shade(if v == none { none } else { v / 20 }), align: center)[#if v == none [–] else [#v]]
