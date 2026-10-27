// Shared stylesheet for all three reports (end-to-end, analysis, transcripts).
// Fonts: IBM Plex Sans (Latin), Alef (Hebrew, OFL, in report/fonts/; compile with --font-path report/fonts).
// Icons: Lucide (ISC), report/icons/*.svg, recoloured at load time.
#import "@preview/cmarker:0.1.6"

#let navy = rgb("#1f3a5f")
#let teal = rgb("#0f766e")
#let amber = rgb("#b45309")
#let red = rgb("#b91c1c")
#let ink = rgb("#1f2937")
#let muted = rgb("#6b7280")
#let paper = rgb("#f6f7f9")
#let line-c = rgb("#e2e5ea")
#let he-font = "Alef"
#let PROJECT = "Who should I vote for?"
#let REPO = "github.com/danielrosehill/Israel-Election-2026-Vote-Decision"
#let REPO-URL = "https://github.com/danielrosehill/Israel-Election-2026-Vote-Decision"

#let md(path) = cmarker.render(read(path), h1-level: 2)

// Lucide icon, recoloured.
#let icon(name, size: 1em, color: navy) = box(baseline: 15%, image(
  bytes(read("/report/icons/" + name + ".svg").replace("currentColor", color.to-hex())),
  height: size, format: "svg"))

#let he(body, size: 1em, weight: "bold") = text(font: he-font, size: size, weight: weight, lang: "he", dir: rtl, body)

// Callout box.
#let callout(body, title: none, color: teal, icon-name: "info") = block(width: 100%, fill: color.lighten(92%), stroke: (left: 3pt + color), inset: (x: 12pt, y: 10pt), radius: (right: 4pt), breakable: false)[
  #if title != none [#text(fill: color, weight: "bold")[#icon(icon-name, color: color) #h(3pt) #title] \ ]
  #body
]

// Section opener: big coloured band with an icon, a kicker ("Stage 3") and a title.
#let section(title, kicker: none, icon-name: none, color: navy) = {
  pagebreak(weak: true)
  block(width: 100%, fill: color, inset: (x: 16pt, y: 14pt), radius: 4pt, below: 14pt)[
    #set text(fill: white)
    #grid(columns: (auto, 1fr), gutter: 12pt, align: horizon,
      if icon-name != none { icon(icon-name, size: 26pt, color: white) },
      [#if kicker != none [#text(9pt, tracking: 1.2pt, weight: "semibold", upper(kicker)) \ ]
       #show heading: set text(20pt, weight: "bold", fill: white)
       #heading(level: 1, outlined: true, bookmarked: true, title)])
  ]
}

// Score shading 0..1, red→amber→green.
#let shade(t) = if t == none { luma(238) } else {
  let t = calc.max(0, calc.min(1, t))
  if t < 0.5 { color.mix((rgb("#ef4444"), 1 - 2 * t), (rgb("#f59e0b"), 2 * t)).lighten(55%) }
  else { color.mix((rgb("#f59e0b"), 2 - 2 * t), (rgb("#16a34a"), 2 * t - 1)).lighten(55%) }
}
#let cell(v, max: 5) = table.cell(fill: shade(if v == none { none } else { v / max }), align: center + horizon)[#if v == none [#text(fill: muted)[–]] else [#v]]
#let pct(v) = table.cell(fill: shade(if v == none { none } else { v / 100 }), align: center + horizon)[#if v == none [#text(fill: muted)[–]] else [#v]]

// Horizontal bar, value 0..max.
#let bar(v, max: 100, width: 100%, color: teal, height: 9pt) = box(width: width, height: height, fill: line-c, radius: 2pt,
  if v != none and v > 0 { align(left + top, box(width: v / max * 100%, height: height, fill: color, radius: 2pt)) })

#let doc(title: "", subtitle: "", kind: "", cover-extra: none, body) = {
  set document(title: title, author: "Daniel Rosehill", keywords: ("Knesset 2026", "Israel election", "AI-assisted voting"))
  set text(font: ("IBM Plex Sans", he-font), size: 10pt, fill: ink, lang: "en")
  set par(justify: true, leading: 0.68em, spacing: 1.05em)
  set page(paper: "a4", margin: (top: 2.3cm, bottom: 2.2cm, x: 2cm),
    header: context {
      if counter(page).get().first() > 1 {
        let pg = here().page()
        let all = query(heading.where(level: 1))
        let on = all.filter(h => h.location().page() == pg)
        let hs = if on.len() > 0 { on } else { all.filter(h => h.location().page() < pg) }
        set text(8pt, fill: muted)
        grid(columns: (1fr, auto), [#icon("vote", size: 9pt, color: muted) #h(3pt) #PROJECT · #kind],
          if hs.len() > 0 { text(fill: navy, weight: "semibold", if on.len() > 0 { hs.first().body } else { hs.last().body }) } )
        v(-4pt); line(length: 100%, stroke: 0.4pt + line-c)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        set text(8pt, fill: muted)
        line(length: 100%, stroke: 0.4pt + line-c); v(-4pt)
        grid(columns: (1fr, auto, 1fr),
          [Daniel Rosehill · Knesset election, 27 October 2026],
          [#text(fill: navy, weight: "semibold")[#counter(page).display()] / #counter(page).final().first()],
          align(right, link(REPO-URL, REPO)))
      }
    })
  show heading.where(level: 1): set text(fill: navy)
  show heading.where(level: 2): it => block(above: 1.5em, below: 0.7em, text(13pt, fill: navy, weight: "bold", it.body))
  show heading.where(level: 3): it => block(above: 1.2em, below: 0.5em, text(10.5pt, fill: teal, weight: "bold", it.body))
  show heading.where(level: 4): it => block(above: 1em, below: 0.4em, text(10pt, weight: "bold", it.body))
  show link: set text(fill: teal)
  set table(stroke: (x, y) => (bottom: 0.5pt + line-c), inset: (x: 6pt, y: 5pt))
  show table: set text(8.5pt)
  show table: set par(justify: false)
  show table.cell.where(y: 0): set text(weight: "bold", fill: navy)
  set list(marker: text(fill: teal)[•])

  // Cover
  page(margin: 0pt, header: none, footer: none)[
    #block(width: 100%, height: 9.5cm, fill: navy, inset: (x: 2cm, top: 2.2cm))[
      #set text(fill: white)
      #icon("vote", size: 34pt, color: white)
      #v(10pt)
      #text(30pt, weight: "bold", title) \
      #v(4pt)
      #text(13pt, fill: white.darken(8%), subtitle)
    ]
    #block(width: 100%, inset: (x: 2cm, top: 1cm))[
      #cover-extra
      #v(1fr)
    ]
    #place(bottom + left, dx: 2cm, dy: -1.6cm, block(width: 17cm)[
      #set text(8.5pt, fill: muted)
      #line(length: 100%, stroke: 0.5pt + line-c)
      #grid(columns: (1fr, 1fr), gutter: 10pt,
        [*Daniel Rosehill* · Jerusalem \ Election to the 26th Knesset, 27 October 2026],
        align(right)[Prepared with Claude Opus 5.5 (Anthropic) \ #link(REPO-URL, REPO)])
    ])
  ]
  counter(page).update(1)
  body
}

// Clickable contents page.
#let contents() = {
  { show heading: set text(18pt, fill: navy); heading(level: 1, outlined: false, bookmarked: false)[Contents] }
  v(6pt)
  show outline.entry.where(level: 1): it => { v(6pt); text(weight: "bold", fill: navy, it) }
  outline(title: none, depth: 2, indent: 1.2em)
}
