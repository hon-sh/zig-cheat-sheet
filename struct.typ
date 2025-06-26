#import "_lib/cram-snap.typ": theader

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
