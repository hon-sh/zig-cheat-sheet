#import "_lib/cram-snap.typ": theader

#table(
  theader[pointer, slice],
  [
    `*T`\ *single-item* pointer to exactly one item.
  ],
  [
    - deref: `ptr.*`
    - slice: `ptr[0..1]`
    - pointer subtraction: `ptr - ptr`
  ],

  [
    `[*]T`\ *many-item* pointer to unknown number of items.
  ],
  [
    - index: `ptr[i]`
    - slice: `ptr[start..end]` and `ptr[start..]`
      - `ptr[start..] == ptr + start`
    - pointer-integer arithmetic: `ptr + int`, `ptr - int`
    - pointer subtraction: `ptr - ptr`
  ],

  table.cell(colspan: 2, box(inset: (left: .5cm, y: .5mm))[
    `T` must have a known size, which means that it cannot be `anyopaque` or any other opaque type.
  ]),

  [
    `*[N]T`\ pointer to N items, same as single-item pointer to an array.
  ],
  [
    - index: `array_ptr[i]`
    - slice: `array_ptr[start..end]`
    - len property: `array_ptr.len`
    - pointer subtraction: `array_ptr - array_ptr`
  ],

  [
    `[]T`\ *slice* (a fat pointer, which contains a pointer of type `[*]T` and a length).
  ],
  [
    - index: `slice[i]`
    - slice: `slice[start..end]`
    - len property: `slice.len`
  ],

  [`?*T`\ *Optional Pointers*],
  [An optional pointer is guaranteed to be the same size as a pointer. The null of the optional is guaranteed to be address 0. `@sizeOf(?*i32) == @sizeOf(*i32)`],

  [`[:x]T`\ *Sentinel-Terminated Slices*, a slice which has a runtime-known length and also guarantees a sentinel value at the element indexed by the length.
  ],
  [
    `const slice: [:0]const u8 = "hello";
expect(slice.len == 5);
expect(slice[5] == 0);
`
    - can created by `data[start..end :x]`, where `data` is a many-item pointer, array or slice and `x` is the sentinel value.
      - element in the sentinel position of the backing data must be the sentinel value
  ],

  [
    `[*c]T`\ *C pointer*. This type is to be avoided whenever possible. The only valid reason for using a C pointer is in auto-generated code from translating C code.
    When importing C header files, it is ambiguous whether pointers should be translated as single-item pointers (`*T`) or many-item pointers (`[*]T`). C pointers are a compromise so that Zig code can utilize translated header files directly.
  ],
  [
    - Supports all the syntax of the other two pointer types (`*T`) and (`[*]T`).
    - Coerces to other pointer types, as well as Optional Pointers. When a C pointer is coerced to a non-optional pointer, safety-checked Illegal Behavior occurs if the address is 0.
    - Allows address 0. On non-freestanding targets, dereferencing address 0 is safety-checked Illegal Behavior. Optional C pointers introduce another bit to keep track of null, just like ?usize. Note that creating an optional C pointer is unnecessary as one can use normal Optional Pointers.
    - Supports Type Coercion to and from integers.
    - Supports comparison with integers.
    - Does not support Zig-only pointer attributes such as alignment. Use normal Pointers please!
  ],

  table.cell(
    colspan: 2,
    box(inset: (left: .5cm, y: .5mm))[
      - When a C pointer is pointing to a single struct (not an array), dereference the C pointer to access the struct's fields or member data. That syntax looks like this:\
        `ptr_to_struct.*.struct_member` (This is comparable to doing `->` in C.)
      - When a C pointer is pointing to an array of structs, the syntax reverts to this:\
        `ptr_to_struct_array[index].struct_member`

    ],
  ),
)
