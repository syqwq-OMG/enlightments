#import "common-utils.typ": *
#import "@preview/physica:0.9.7":*

#let translation = (
  problem: (
    zh: "问题",
    en: "Problem",
  ),
  proof: (
    zh: "证明",
    en: "Proof",
  ),
  solution: (
    zh: "解答",
    en: "Solution",
  ),
)

// scr 花体
#let scr(it) = text(
  stylistic-set: 1,
  box($cal(it)$),
)

#let span = math.op("span")
#let Var = math.op("Var")
#let Cov = math.op("Cov")
#let Pr = math.op("Pr")
#let ind = math.op("ind")
#let rank = math.op("rank")
#let tr = math.op("tr")
#let diag = math.op("diag")
#let null = math.op("null")
#let eigen = math.op("eigen")
#let dim = math.op("dim")
#let char = math.op("char")
#let Gal = math.op("Gal")
#let Aut = math.op("Aut")
#let Inv = math.op("Inv")
#let End = math.op("End")
#let oint = math.integral.cont
#let oiint = math.integral.surf
#let oiiint = math.integral.vol
#let iint = math.integral.double
#let iiint = math.integral.triple
#let argmin = math.op("argmin", limits: true)
#let argmax = math.op("argmax", limits: true)
#let up = math.arrow.t
#let to = math.arrow.r
#let down = math.arrow.b

#let pmat = math.mat.with(delim: "(")
#let bmat = math.mat.with(delim: "[")
#let detm = math.mat.with(delim: "|")

// 加法表、乘法表
#let symbol-table(r: 2, c: 2) = table.with(
  rows: r,
  columns: c,
  align: (right + bottom,) + (center + bottom,) * (c - 1),
  stroke: (x, y) => {
    if x == 0 and y == 0 { (right: black + 0.7pt, bottom: black + 0.7pt) } else if x == 0 {
      (right: black + 0.7pt)
    } else if y == 0 { (bottom: black + 0.7pt) }
  },
)

#let show-math-format(body) = {
  // 数学公式中的汉字字体
  show math.equation: it => {
    show regex("\p{script=Han}"): set text(font: cn-font-serif, weight: "light")
    it
  }
  // 默认矩阵是方
  set math.mat(delim: "[")
  set math.vec(delim: "[")
  // 增加大括号和文字的间距
  set math.cases(gap: 0.5em)

  // 给带有 label 的公式编号
  show math.equation: it => {
    if it.fields().keys().contains("label") and it.label != el.adv.native-format-label{
      math.equation(
        block: true,
        numbering: n => {
          let count = counter(heading).get()
          let h1 = count.first()
          let h2 = count.at(1, default: 0)
          numbering("(1.1.1)", h1, h2, n)
        },
        it,
      )
    } else {
      it
    }
  }

  show ref: it => context {
    let ell = it.element
    if ell != none and ell.func() == math.equation {
      let count = counter(heading).at(ell.location())
      let h1 = count.first()
      let h2 = count.at(1, default: 0)
      let fmt = "Eq"
      if text.lang == "zh" { fmt = "式" }
      link(ell.location(), numbering(
        fmt + " (1.1.1)",
        h1,
        h2,
        counter(math.equation).at(ell.location()).at(0) + 1,
      ))
    } else {
      it
    }
  }

  body
}
