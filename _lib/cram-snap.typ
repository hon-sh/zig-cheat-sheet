// 0.2.2 of https://typst.app/universe/package/cram-snap

#let table_stroke(color) = (
  (x, y) => (
    left: none,
    right: none,
    top: none,
    bottom: if y == 0 {
      color
    } else {
      0pt
    },
  )
)

#let table_fill(color) = (
  (x, y) => {
    if calc.odd(y) {
      rgb(color)
    } else {
      none
    }
  }
)

#let theader(..cells, colspan: 2) = table.header(
  ..cells
    .pos()
    .map(x => if type(x) == content and x.func() == table.cell {
      x
    } else {
      table.cell(colspan: colspan, x)
    }),
  ..cells.named(),
)
