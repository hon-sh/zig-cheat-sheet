#import "_lib/cram-snap.typ": theader

#{
  set table(inset: (x: 1.5mm, y: 1.7mm))

  table(
    columns: (30mm, 1fr),

    theader[std.fmt format string],

    table.cell(
      colspan: 2,

      grid(
        columns: (1fr, 124mm),
        [
          format string must be comptime-known and may contain placeholders in this format:\
          `{[argument][specifier]:[fill][alignment][width].[precision]}`\
          To print literal curly braces, escape them by writing them twice, e.g. `{{` or `}}`.
        ],
        text(size: 8pt)[
          *Note*: most of the parameters are optional and may be omitted.
          Also you can leave out separators like `:` and `.` when all parameters after the separator are omitted.
          Only exception is the *fill* parameter. If a non-zero fill character is required at the same time as width is specified, one has to specify alignment as well, as otherwise the digit following `:` is interpreted as width, not fill.
        ],
      ),
    ),

    [`argument`], [
      `[score]` - field name (an identifier) enclose in square brackets\
      `2` - numeric index (omit means use next argument)
    ],

    [`specifier`], [
      #box(inset: (top: 2mm))[
        a type-dependent formatting option that determines how a type should formatted
      ]

      #show table.cell.where(x: 0): it => [
        #align(center)[
          #it.body
        ]
      ]

      #table(
        columns: (14mm, 1fr),
        [`x`, `X`], [output numeric value in hexadecimal notation],
        [`s`],
        [
          for pointer-to-many and C pointers of u8, print as a C-string using zero-termination\
          for slices of u8, print the entire slice as a string without zero-termination
        ],

        [`e`], [ output floating point value in scientific notation ],
        [`d`], [ output numeric value in decimal notation ],
        [`b`], [ output integer value in binary notation ],
        [`o`], [ output integer value in octal notation ],
        [`c`], [ output integer as an ASCII character. Integer type must have 8 bits at max. ],
        [`u`], [ output integer as an UTF-8 sequence. Integer type must have 21 bits at max. ],
        [`?`],
        [
          output optional value as either the unwrapped value, or null;\
          may be followed by a format specifier for the underlying value.
        ],

        [`!`],
        [
          output error union value as either the unwrapped value, or the formatted error value;\
          may be followed by a format specifier for the underlying value.
        ],

        [`*`], [ output the address of the value instead of the value itself. ],
        [`any`], [ output a value of any type using its default format. ],
      )
    ],


    [`fill`], [
      is a single unicode codepoint which is used to pad the formatted text
    ],

    [`alignment`], [
      is one of the three bytes `<`, `^`, or `>` to make the text left-, center-, or right-aligned, respectively
    ],

    [`width`], [
      is the total width of the field in unicode codepoints
    ],

    [`precision`], [
      specifies how many decimals a formatted number should have
    ],

    table.cell(
      colspan: 2,
      stroke: (top: rgb("#333")),
      block(
        inset: (x: 0mm, y: 0mm, left: 6mm, top: 1mm),
        outset: 0mm,
      )[
        value with `struct`, `vector`, `unioni` or `enum` type can have a custom formatting function defined as:\

        ```zig
        pub fn format(value: ?, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void
        ```

        with ? being the type formatted, this function will be called instead of the default implementation.
      ],
    )
  )
}
