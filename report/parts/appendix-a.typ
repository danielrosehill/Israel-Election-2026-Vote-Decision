#import "../style.typ": *

#section("Appendix A · The voice note", kicker: "Transcript, disfluencies removed", icon-name: "file-text", color: teal)

My exact words and order from the 26 October 2026 recording, with only fillers, stutters and immediate repeats removed and known mishearings corrected. Times refer to the original 42-minute recording. The raw AssemblyAI transcript and a more heavily edited, sectioned version are in the repository.

#{
  let src = read("/context/voice-notes/2026-10-26-politics/transcript-disfluencies-removed.md")
  let body = src.split("\n---\n").slice(1).join("\n---\n")
  let paras = body.split("\n\n").map(p => p.trim()).filter(p => p.starts-with("["))
  set par(justify: true, leading: 0.62em)
  for p in paras {
    let m = p.match(regex("^\[(\d+:\d+)\]\s*(.*)$"))
    if m != none {
      block(breakable: true, below: 7pt, grid(columns: (34pt, 1fr), gutter: 8pt,
        text(8pt, fill: teal, weight: "bold", m.captures.at(0)), text(9.5pt, m.captures.at(1))))
    }
  }
}
