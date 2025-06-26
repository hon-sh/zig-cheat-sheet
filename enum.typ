#import "_lib/cram-snap.typ": theader

#columns(2)[
  #table(
    theader[enum, union],
    [*enum*\ tag type], [`const Type = enum {
  ok, not_ok,
};
const Value = enum(u2) {
  zero, one, two,
};
const Value2 = enum(u32) {
  hundred = 100,
  thousand = 1000,
  million = 1000000,
};
const Value3 = enum(u4) {
  a,
  b = 8, c,
  d = 4, e,
};
`],
    [*extern enum*\ By default, enums are not guaranteed to be compatible with the C ABI], [`const Foo = enum(c_int) { a, b, c };
export fn entry(foo: Foo) void {
    _ = foo;
} `],
    [Non-exhaustive enum], [`const Number = enum(u8) {
    one, two,
    _,
};
const result = switch (number) {
  .one, .two => true,
  _ => false,
};
const is_one = switch (number) {
  .one => true,
  else => false,
};
`],
  )

  #colbreak()

  #table(
    theader[opaque, c],
    [TBD], [],
  )

]