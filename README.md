# fktts — fast kickstart Typst template set

A single-folder Typst template for math notes: low-saturation color cards for
definitions, theorems and proofs, chapter-scoped numbering, and an optional
equation-number toggle.

There are no `@preview/*` imports. `main.typ` and `math-boxes.typ` are the whole
template, and they build offline.

## Files

| File | Purpose |
| --- | --- |
| `main.typ` | Entry point: page setup, fonts, cover page, table of contents, sample notes |
| `math-boxes.typ` | Card functions (`theorem`, `definition`, …), counters and colors |
| `main.pdf` | Generated output; rebuild it after cloning |
| `LICENSE` | MIT |

## Requirements

- Typst (tested with 0.15.1) — check with `typst --version`
- Three font families, installed locally and not shipped with the template:
  - **Monaspace Xenon** and **Monaspace Radon** — <https://github.com/githubnext/monaspace>
  - **LXGW WenKai** — <https://github.com/lxgw/LxgwWenKai>
  - **New Computer Modern Math** — <https://ctan.org/pkg/newcomputermodern>

Confirm what Typst sees with:

```sh
typst fonts --variants | grep -E 'Monaspace|LXGW|New Computer Modern'
```

## Usage

```sh
typst watch main.typ     # rebuild main.pdf on save
typst compile main.typ   # one-shot build
```

Then open `main.pdf` in any viewer.

## Workflow

Split screen: editor on the left, PDF viewer on the right, `typst watch` in a
terminal. Every save triggers a rebuild and the viewer picks the new file up, so
the right pane follows the edit.

```text
Zed  >  typst watch main.typ  >  sioyek
```

The author's setup is Zed on the left and sioyek on the right; any other editor
and any auto-reloading PDF viewer work the same way.

## Design

- **Cards.** Every environment is a full-width block with a low-saturation tint,
  a 2.4 pt accent bar on the left edge, 4 pt corner radius, and `breakable: true`
  so long statements can flow across pages.
- **English labels.** Headers are English-only and read like
  `Definition 2.1 Continuity`, `Theorem 2.2 Monotone convergence` — the title
  follows the number after a single space, with no separator glyph.
- **Chapter-scoped counters.**
  - `theorem`, `lemma`, `proposition`, `corollary` share one counter
  - `definition` has its own
  - `example` has its own
  - `exercise` has its own
  - `remark` and `proof` are unnumbered

  Every level-1 heading calls `reset-math-counters()`, so the first theorem of
  chapter 3 is `Theorem 3.1` and the equation counter restarts as well.
- **Equation numbers are off by default.** Set `#let number-equations = true` at
  the top of `main.typ` to get `(1.1)`, `(1.2)`, … restarting in each chapter.
- **Blue links.** `#show link: set text(fill: rgb("#2563EB"))` keeps hyperlinks
  visible in print and on screen; outline entries stay in body color.
- **Page flow.** Cover page, then a standalone table of contents, then the body.

## Fonts

| Role | Family |
| --- | --- |
| Body Latin | Monaspace Xenon |
| Bold Latin, headings, cover subtitle | Monaspace Radon |
| Chinese | LXGW WenKai |
| Math | New Computer Modern Math |

Monaspace has no CJK coverage, so Chinese glyphs fall back to LXGW WenKai
through the font list in `#set text(font: …)`. Bold text is redirected to
Monaspace Radon with `#show strong`, which is why the Latin bold face looks
different from the Latin body face.

## Customizing

- **Colors.** Edit the `colors` dictionary at the top of `math-boxes.typ`. Each
  entry provides `accent` (bar and header text) and `fill` (card tint).
- **Fonts.** Change `#set text(font: …)` and the `#show heading` / `#show strong`
  rules at the top of `main.typ`.
- **Numbering.** Keep the level-1 heading rule that calls

  ```typst
  #show heading.where(level: 1): it => {
    reset-math-counters()
    counter(math.equation).update(0)
    it
  }
  ```

  Without it, counters run across chapters.

## Reusing the boxes in another project

Copy `math-boxes.typ` next to your document, import what you need, and add the
reset rule above:

```typst
#import "math-boxes.typ": theorem, definition, lemma, proposition, corollary,
  example, remark, proof, exercise, reset-math-counters

#show heading.where(level: 1): it => {
  reset-math-counters()
  counter(math.equation).update(0)
  it
}
```

## Credits and inspiration

- **minimal-note** by Michel Liao — <https://github.com/Michel-Liao/minimal-note>.
  The paper-style single-column layout and the card-based note boxes started from
  this template (MIT No Attribution).
- **Monaspace** by GitHub Next — <https://github.com/githubnext/monaspace>
  (SIL Open Font License 1.1).
- **LXGW WenKai** by LXGW — <https://github.com/lxgw/LxgwWenKai>
  (SIL Open Font License 1.1).
- **New Computer Modern** by Antonis Tsolomitis — <https://ctan.org/pkg/newcomputermodern>
  (GUST Font License).

The color palette, the chapter-scoped counter scheme, and the local
`math-boxes.typ` were written for this template.

## License

MIT. See [`LICENSE`](LICENSE).
