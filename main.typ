#import "lib.typ": math-note
#import "utils.typ": *
#import math-note: note

#show: note.with(
  watermark: none,
  author: "syqwq",
  course: "随机问题",
  course-alt: [$EE$nlightments],
  mail: "3422403944@qq.com",
)
#set text(lang: "zh")
#set par(justify: true)
#show math.equation: math.display


#include "chapters/probability.typ"
#include "chapters/conditional-exp.typ"
#pagebreak()

#include "chapters/fisher.typ"