// Minimal color boxes for mathematical notes.
// No third-party Typst packages are required.

// Change these colors to customize the whole template.
#let colors = (
  theorem: (accent: rgb("#456B91"), fill: rgb("#F0F5FA")),
  definition: (accent: rgb("#3D796E"), fill: rgb("#EDF6F2")),
  example: (accent: rgb("#AE824D"), fill: rgb("#FBF6ED")),
  remark: (accent: rgb("#786A93"), fill: rgb("#F5F2F9")),
  proof: (accent: rgb("#65727B"), fill: rgb("#F5F7F8")),
  exercise: (accent: rgb("#A66865"), fill: rgb("#FBF2F1")),
)

// Numbering is chapter-based: 1.1, 1.2, 2.1, ...
// Theorem / lemma / proposition / corollary share a counter.
// Definition, example, and exercise have separate counters.
#let thm-count = counter("math-note-thm")
#let def-count = counter("math-note-def")
#let ex-count = counter("math-note-example")
#let task-count = counter("math-note-exercise")

// Call at the beginning of every level-one heading.
// The wrapper in main.typ does this automatically.
#let reset-math-counters() = [
  #thm-count.update(0)
  #def-count.update(0)
  #ex-count.update(0)
  #task-count.update(0)
]

// Turn the current chapter number and the local item number into "1.1".
#let chapter-number(count) = numbering(
  "1.1",
  counter(heading).get().first(),
  count.get().first(),
)

#let caption(label, number: none, title: none) = {
  let head = if number == none { label } else { [#label #number] }
  if title == none { head } else { [#head #title] }
}

#let note-card(heading, body, accent: rgb("#456B91"), tint: rgb("#F0F5FA")) = block(
  width: 100%,
  fill: tint,
  stroke: (left: (paint: accent, thickness: 2.4pt)),
  radius: 4pt,
  inset: (left: 12pt, right: 12pt, top: 10pt, bottom: 11pt),
  above: 10pt,
  below: 10pt,
  breakable: true,
)[
  #text(font: ("Monaspace Radon", "霞鶩文楷"), fill: accent, weight: "bold", size: 10pt)[#heading]
  #v(5pt)
  #body
]

#let numbered(label, count, style, body, title: none) = [
  #count.step()
  #context note-card(
    caption(label, number: chapter-number(count), title: title),
    body,
    accent: style.accent,
    tint: style.fill,
  )
]

#let theorem(body, title: none) = numbered(
  [Theorem], thm-count, colors.theorem, body, title: title,
)

#let lemma(body, title: none) = numbered(
  [Lemma], thm-count, colors.theorem, body, title: title,
)

#let proposition(body, title: none) = numbered(
  [Proposition], thm-count, colors.theorem, body, title: title,
)

#let corollary(body, title: none) = numbered(
  [Corollary], thm-count, colors.theorem, body, title: title,
)

#let definition(body, title: none) = numbered(
  [Definition], def-count, colors.definition, body, title: title,
)

#let example(body, title: none) = numbered(
  [Example], ex-count, colors.example, body, title: title,
)

#let exercise(body, title: none) = numbered(
  [Exercise], task-count, colors.exercise, body, title: title,
)

#let remark(body, title: none) = note-card(
  caption([Remark], title: title),
  body,
  accent: colors.remark.accent,
  tint: colors.remark.fill,
)

#let proof(body, title: none) = note-card(
  caption([Proof], title: title),
  body,
  accent: colors.proof.accent,
  tint: colors.proof.fill,
)
