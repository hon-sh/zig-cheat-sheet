// 0.2.2 of https://typst.app/universe/package/cram-snap

#let table_stroke(color) = (
  (x, y) => (
    left: none,
    right: none,
    top: none,
    bottom: none,
  )
)

#let table_fill(color) = (
  (x, y) => {
    if calc.odd(y) {
      rgb(color)
    } else {
      // none
      white
    }
  }
)

#let stroke-color = "21222C"
#let theader(..cells, colspan: 2) = {
  return table.header(
    ..cells
      .pos()
      .map(x => if type(x) == content and x.func() == table.cell {
        x.with(bottom: rgb(stroke-color), body: x.body.with(weight: "bold", size: 1.2em))
      } else {
        table.cell(
          colspan: colspan,
          stroke: (
            bottom: rgb(stroke-color),
          ),
          text(x, weight: "bold", size: 1.2em),
        )
      }),
    ..cells.named(),
  )
}

