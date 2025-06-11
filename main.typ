#import "_lib/cram-snap.typ": table_fill, table_stroke, theader

#set page(
  paper: "a4",
  flipped: true,
  margin: (top: 1.3cm, bottom: .2cm, left: .6cm, right: .6cm),
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

#set text(font: "Arial", size: 11pt)
#let fill-color = "F6F6F6"
#let stroke-color = "21222C"
#set table(
  align: left + horizon,
  columns: (2fr, 3fr),
  inset: (x: 1.5mm, y: 1mm),
  fill: table_fill(rgb(fill-color)),
  stroke: table_stroke(rgb(stroke-color)),
)
#set table.header(repeat: false)
#show table.cell.where(y: 0): set text(weight: "bold", size: 1.2em)

#show raw.where(block: false): it => {
  box(fill: rgb("#a9fca530"), inset: 0.5mm, radius: 0.2mm, outset: (y: 0mm), it)
}

#show link: underline

#columns(2)[
  #table(
    theader[values],
    [`i32, f32, u8, isize, usize`], [??],
    [`bool, anyopaque, anyerror`], [??],
    [`true/false, null, undefined`], [??],
    [`const bytes = "hello";`], [`@TypeOf(bytes) => *const [5:0]u8` #"\n" `bytes[5] => 0`],
    [`'\u{1f4a9}', '💯'`], [`\xNN, \u{NNNNNN}`],
    [`var x: u32 = undefined;
const tuple = .{ 1, 2, 3 };
x, var y: u32, const z = tuple;`], [*Destructuring*.],
  )

  #table(
    theader[operators],
    [`a orelse b`], [*Defaulting Optional Unwrap*. If a is null, returns b ("default value"), otherwise returns the unwrapped value of a.],
    [`a.?`], [*Optional Unwrap*. \= `a orelse unreachable`],
    [`a catch b
a catch |err| b`], [*Defaulting Error Unwrap*. If a is an error, returns b ("default value"), otherwise returns the unwrapped value of a.],
    [`a == null`], [null check],
    [`a.*`], [*Pointer Dereference*.],
    [`&a`], [*Address Of*.],
    [`a || b`], [*Error Set Merge*.],
    table.cell(
      colspan: 2,
      [*Precedence:*\ `x() x[] x.y x.* x.?
a!b
x{}
!x -x -%x ~x &x ?x
* / % ** *% *| ||
+ - ++ +% -% +| -|
<< >> <<|
& ^ | orelse catch
== != < > <= >=
and
or
= *= *%= *|= /= %= += +%= +|= -= -%= -|= <<= <<|= >>= &= ^= |=
`],
    )
  )

  #colbreak()
  #table(
    theader[pointer, slice],
    [
      `*T`\ *single-item* pointer to exactly one item.
    ], [
      - deref: `ptr.*`
      - slice: `ptr[0..1]`
      - pointer subtraction: `ptr - ptr`
    ],

    [
      `[*]T`\ *many-item* pointer to unknown number of items.
    ], [
      - index: `ptr[i]`
      - slice: `ptr[start..end]` and `ptr[start..]`
        - `ptr[start..] == ptr + start`
      - pointer-integer arithmetic: `ptr + int`, `ptr - int`
      - pointer subtraction: `ptr - ptr`
    ],

    table.cell(
      colspan: 2,
      box(inset: (left: .5cm, y: .5mm))[
        `T` must have a known size, which means that it cannot be `anyopaque` or any other opaque type.
      ],
    ),

    [
      `*[N]T`\ pointer to N items, same as single-item pointer to an array.
    ], [
      - index: `array_ptr[i]`
      - slice: `array_ptr[start..end]`
      - len property: `array_ptr.len`
      - pointer subtraction: `array_ptr - array_ptr`
    ],

    [
      `[]T`\ *slice* (a fat pointer, which contains a pointer of type `[*]T` and a length).
    ], [
      - index: `slice[i]`
      - slice: `slice[start..end]`
      - len property: `slice.len`
    ],

    [`?*T`\ *Optional Pointers*], [An optional pointer is guaranteed to be the same size as a pointer. The null of the optional is guaranteed to be address 0. `@sizeOf(?*i32) == @sizeOf(*i32)`],

    [`[:x]T`\ *Sentinel-Terminated Slices*, a slice which has a runtime-known length and also guarantees a sentinel value at the element indexed by the length.
    ], [
      `const slice: [:0]const u8 = "hello";
expect(slice.len == 5);
expect(slice[5] == 0);
`
      - can created by `data[start..end :x]`, where `data` is a many-item pointer, array or slice and `x` is the sentinel value.
        - element in the sentinel position of the backing data must be the sentinel value
    ],
  )
]

#pagebreak()
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

#pagebreak()
#table(
  theader[struct],
  [`const Point = struct {
  x: f32,
  y: f32,
};`], [Struct field order is determined by the compiler,\ however, a base pointer
    can be computed from a field pointer:\
    `fn setYBasedOnX(x: *f32, y: f32) void {
  const point: *Point = @fieldParentPtr("x", x);
  point.y = y;
}
var point = Point{ .x = 0.1234, .y = 0.5678, };
setYBasedOnX(&point.x, 0.9);
expect(point.y == 0.9);
`],

  [` const Vec3 = struct {
  x: f32,
  y: f32,
  z: f32,
  pub fn init(x: f32, y: f32, z: f32) Vec3 {
    return Vec3{ .x = x, .y = y, .z = z, };
  }
  pub fn dot(self: Vec3, o: Vec3) f32 {
    return self.x * o.x + self.y * o.y + self.z * o.z;
  }
};
  `], [Functions in the struct's *namespace* can be called with *dot syntax*.\
    `const v1 = Vec3.init(1.0, 0.0, 0.0);
const v2 = Vec3.init(0.0, 1.0, 0.0);
expect(v1.dot(v2) == 0.0);`

    Other than being available to call with dot syntax, struct methods are not special.\
    You can reference them as any other declaration inside the struct:\
    `expect(Vec3.dot(v1, v2) == 0.0);
`],

  [`
const Empty = struct {
  pub const PI = 3.14;
};
  `], [],

  [*extern struct*], [An extern struct has in-memory layout matching the C ABI for the target.\ TBD],
  [*packed struct*], [TBD],
)



#pagebreak()
#include "type.typ";


#pagebreak()
#columns(2)[
  #table(
    theader[switch],
    [TBD], [],
  )
  #table(
    theader[while],
    [TBD], [],
  )

  #colbreak()
  #table(
    theader[for],
    [TBD], [],
  )
  #table(
    theader[if],
    [TBD], [],
  )
  #table(
    theader[defer, errdefer],
    [TBD], [],
  )

]
