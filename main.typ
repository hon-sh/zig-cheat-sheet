#import "_lib/cram-snap.typ": table_fill, table_stroke, theader

#set page(
  width: 29.7cm,
  height: auto,
  margin: (top: 1.3cm, bottom: .5cm, left: .6cm, right: .6cm),
  header: block(width: 100%)[
    #align(center)[
      #box(height: 1.8em)[
        #set image(height: 100%)
        #box(image("zig-logo-dark.svg"), baseline: 20%)
        #text(1.6em, " Cheatsheet")
      ]
    ]
    #place(
      right + top,
      dx: -2mm,
      dy: 1mm,
      [#link("https://ziglang.org")[ziglang.org] zig v0.14 \ by hon.sh],
    )
  ],
)

#show heading.where(level: 1): it => { }

#set text(font: "Arial", size: 11pt)
#let fill-color = "F6F6F6"
#set table(
  align: left + horizon,
  columns: (2fr, 3fr),
  inset: (x: 1.5mm, y: 1.3mm),
  fill: table_fill(rgb(fill-color)),
  stroke: table_stroke(none),
)
#set table.header(repeat: false)

#show raw.where(block: false): it => {
  box(fill: rgb("#a9fca530"), inset: 0.5mm, radius: 0.2mm, outset: (y: 0mm), it)
}

#show link: underline

#include "basic-type.typ";

#pagebreak()
#include "pointer.typ";

#pagebreak()
#include "enum.typ";

#pagebreak()
#include "build.typ";

#pagebreak()
#include "struct.typ";

#pagebreak()
= std.fmt
#include "fmt.typ";

#pagebreak()
= std.builtin.Type
#include "type.typ";

#pagebreak()
#include "control.typ";
