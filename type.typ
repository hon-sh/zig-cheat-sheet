#import "_lib/cram-snap.typ": theader

#let s = super[+]

#table(
  columns: (4cm, 1fr),

  theader[std.builtin.Type],
  // table.cell(colspan: 2, [*std.builtin.Type*]),

  [`type`], [`type`],
  [`void`], [`void`],
  [`bool`], [`bool`],
  [`noreturn`], [],
  [`int`#s], [`u8`],
  [`float`#s], [`f8`],
  [`pointer`#s], [`[]T, *T`],
  [`array`#s], [`[1]T`],
  [`@"struct"`#s], [],
  [`comptime_float`], [],
  [`comptime_int`], [],
  [`undefined`], [],
  [`null`], [],
  [`optional`#s], [],
  [`error_union`#s], [],
  [`error_set`#s], [],
  [`@"enum"`#s], [],
  [`@"union"`#s], [],
  [`@"fn"`#s], [],
  [`@"opaque"`#s], [],
  [`frame`#s], [],
  [`@"anyframe"`#s], [],
  [`vector`#s], [],
  [`enum_literal`], [],
)
