#import "math-boxes.typ": theorem, definition, lemma, proposition, corollary, example, remark, proof, exercise, reset-math-counters

// =========================================================
// 1. Global settings (edit these first)
// =========================================================
#set document(title: "测度论与概率论笔记", author: "数学学习笔记")
#set page(
  paper: "a4",
  margin: (x: 2.35cm, y: 2.4cm),
  numbering: "1",
  number-align: center,
)

// Chinese: LXGW WenKai; English: Monaspace Xenon.
// Bold/latin headings: Monaspace Radon.
#set text(
  font: ("Monaspace Xenon", "霞鶩文楷"),
  size: 10.5pt,
  lang: "zh",
)
#show math.equation: set text(font: "New Computer Modern Math")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.1")

// =========================================================
// Equation numbers: false = none; true = (1.1), (1.2), (2.1), ...
// Change this single switch to choose your preferred style.
// =========================================================
#let number-equations = false
#let chapter-equation-number(n) = {
  let chapter = counter(heading).get().first()
  numbering("(1.1)", chapter, n)
}
#set math.equation(numbering: if number-equations {
  chapter-equation-number
} else {
  none
})

#show heading.where(level: 1): set text(size: 15pt, fill: rgb("#344354"))
#show heading.where(level: 2): set text(size: 12pt, fill: rgb("#344354"))

#show heading: set text(font: ("Monaspace Radon", "霞鶩文楷"))
#show strong: set text(font: ("Monaspace Radon", "霞鶩文楷"))
#show link: set text(fill: rgb("#2563EB"))

// Every new chapter resets all math-card counters and equation numbers.
// Chapter 1: Theorem 1.1; Chapter 2: Theorem 2.1.
#show heading.where(level: 1): it => {
  reset-math-counters()
  counter(math.equation).update(0)
  it
}

// =========================================================
// 2. Cover page and a separate table-of-contents page
// =========================================================
#align(center)[
  #v(22%)
  #text(size: 24pt, weight: "bold", fill: rgb("#344354"))[测度论与概率论笔记]
  #v(12pt)
  #text(font: ("Monaspace Radon", "霞鶩文楷"), size: 11pt, fill: rgb("#677786"))[Notes on Measure Theory and Probability]
  #v(23pt)
  #text(size: 10pt)[数学学习笔记]
  #v(8pt)
  #text(size: 9pt, fill: rgb("#677786"))[#datetime.today().display("[year]-[month]-[day]")]
]

#pagebreak()
#outline(title: [目录 · Contents], depth: 2)
#pagebreak()

// =========================================================
// 3. Sample content. Replace with your own notes.
// =========================================================
= 引言

这是一份以 *简洁、低饱和颜色、数学友好* 为目标的 Typst 笔记模板。正文使用霞鶩文楷作为中文字体，优先使用 Monaspace Xenon，标题与粗体英文使用 Monaspace Radon。所有颜色框都来自本地的 `math-boxes.typ`，不需要在线下载依赖。

== 如何编写数学内容

若想让公式右侧显示 `(1.1)`、`(1.2)`，
将文件顶部的 `number-equations` 改成 `true`；
默认 `false`，所以公式只显示内容，不显示编号。

行内公式，例如 $P(A) = 1$，直接写在一行内；独立公式使用两侧留空格的数学模式：

$ integral_X f dif mu = 1 $

= 定义、定理与证明

== 可测性

#definition(title: [可测函数])[
  设 $(X, cal(F))$ 和 $(Y, cal(G))$ 为可测空间。若对每个 $B in cal(G)$，都有
  $ f^(-1)(B) in cal(F), $
  则称 $f: X -> Y$ 为可测函数。
]

#definition(title: [可测集合])[
  如果 $A in cal(F)$，则称 $A$ 是一个可测集合。
]

#remark(title: [阅读提示])[
  本章中的定义编号依次为 2.1、2.2；下一章的定义会从 3.1 重新开始。
  不同环境使用不同低饱和颜色，修改 `math-boxes.typ` 中的 `colors` 即可统一换色。
]

== 积分与收敛

#lemma(title: [积分的单调性])[
  若 $0 <= f <= g$ 且二者可测，则
  $ integral_X f dif mu <= integral_X g dif mu. $
]

#theorem(title: [Levi 单调收敛定理])[
  设 $f_n$ 为非负可测函数列，并且 $f_n(x)$ 对每个 $x$ 单调递增到 $f(x)$。那么
  $ lim_(n -> oo) integral_X f_n dif mu = integral_X f dif mu. $
]

#proof[
  由积分的单调性，左侧极限不超过右侧。反向不等式可由非负简单函数逼近，并结合测度的下连续性得到。完整证明可以在此继续展开。
]

#corollary(title: [非负级数的逐项积分])[
  若 $g_n >= 0$ 可测，则
  $ integral_X (sum_(n=1)^oo g_n) dif mu = sum_(n=1)^oo integral_X g_n dif mu. $
]

= 例子与练习

#definition(title: [随机变量])[
  设 $(Omega, cal(F), P)$ 为概率空间。若 $X: Omega -> RR$ 可测，
  则称 $X$ 为实值随机变量。注意它在新的一章中编号为 3.1。
]

#example(title: [等差数列求和])[
  对任意正整数 $n$，
  $ sum_(k=1)^n k = (n(n+1))/2. $
  这类计算很适合用琥珀色的 Example 框来展示。
]

#exercise(title: [一个基本不等式])[
  设 $X$ 为非负随机变量，且 $a > 0$。尝试证明
  $ P(X >= a) <= E(X) / a. $
]

#proposition(title: [简单推论])[
  若 $A subset.eq B$ 且 $mu$ 为测度，则 $mu(A) <= mu(B)$。
]

= 参考资料

- #link("https://typst.app/docs/")[Typst 官方文档]
- #link("https://typst.app/docs/reference/math/")[Typst 数学公式参考]
- #link("https://typst.app/universe/package/minimal-note/")[Minimal Note 模板]
- #link("https://github.com/Michel-Liao/minimal-note")[Minimal Note GitHub 源码]

以后可以只复制 `#definition[...]`、`#theorem[...]` 等内容块，快速记下数学定义、结论和证明。
