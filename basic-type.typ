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

]