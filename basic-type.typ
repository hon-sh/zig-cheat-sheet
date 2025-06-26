#import "_lib/cram-snap.typ": theader

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