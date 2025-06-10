// 0.2.2 of https://typst.app/universe/package/cram-snap

#let cram-snap(
  fill-color: "F6F6F6",
  stroke-color: "21222C",
  doc,
) = {
  let table_stroke(color) = (
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

  let table_fill(color) = (
    (x, y) => {
      if calc.odd(y) {
        rgb(color)
      } else {
        none
      }
    }
  )

  set table(
    align: left + horizon,
    columns: (2fr, 3fr),
    inset: (x: 1.5mm, y: 1mm),
    fill: table_fill(rgb(fill-color)),
    stroke: table_stroke(rgb(stroke-color)),
  )

  set table.header(repeat: false)

  show table.cell.where(y: 0): set text(weight: "bold", size: 1.2em)

  doc
}

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
