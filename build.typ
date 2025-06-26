#import "_lib/cram-snap.typ": theader

#table(
  columns: (4.2cm, 6cm, 1fr),
  theader(colspan: 3)[build system - steps],

  [`top_level`],
  [`b.step()`],
  [
    - install, uninstall
    - user: run, test

    Note: Only steps created with b.step() will appear in zig build -l/-\-list-steps.\ Below steps more like task, you need to add these tasks as dependencies of a top_level step to execute them.
  ],

  [`compile`],
  [
    - `b.addExecutable()`
    - `b.addObject()`
    - `b.addLibrary()`
    - `b.addTest()`
  ],
  [],

  [`run`],
  [
    - `b.addSystemCommand()`
    - `b.addRunArtifact()`
  ],
  [],

  [`install_artifact`], [`b.addInstallArtifact()`], [],

  [`install_file`],
  [
    - `b.addInstallFile()`
    - `b.addInstallBinFile()`
    - `b.addInstallLibFile()`
    - `b.addInstallHeaderFile()`
    - `b.addInstallFileWithDir()`
  ],
  [],

  [`install_dir`], [`b.addInstallDirectory()`], [],
  [`remove_dir`], [`b.addRemoveDirTree()`], [],
  [`fail`], [`b.addFail()`], [],
  [`fmt`], [`b.addFmt()`], [run `zig fmt`],
  [`translate_c`], [`b.addTranslateC()`], [],
  [`write_file`],
  [
    - `b.addWriteFile()`
    - `b.addWriteFiles()`
    - `b.addNamedWriteFiles()`
  ],
  [],

  [`update_source_files`], [`b.addUpdateSourceFiles()`], [],

  [`check_file`], [`b.addCheckFile()`], [],
  [`check_object`], [], [],
  [`config_header`], [`b.addConfigHeader()`], [],
  [`objcopy`], [`b.addObjCopy()`], [],
  [`options`], [], [],
  [`custom`],
  [],
  [
    build.zig:\
    `const std = @import("std");
const Step = std.Build.Step;

pub fn build(b: *std.Build) void {
    b.step("hi", "say hi").dependOn(
        &HiStep.create(b, "you").step,
    );
}

const HiStep = struct {
    name: []const u8,
    step: Step,

    fn create(owner: *std.Build, name: []const u8) *HiStep {
        const hi = owner.allocator.create(HiStep) catch @panic("OOM");
        hi.* = .{
            .name = name,
            .step = std.Build.Step.init(.{
                .id = .custom,
                .name = "",
                .owner = owner,
                .makeFn = make,
            }),
        };
        return hi;
    }

    fn make(step: *Step, options: Step.MakeOptions) !void {
        _ = options;
        const hi: *HiStep = @fieldParentPtr("step", step);
        std.debug.print("hi {s}\n", .{hi.name});
    }
};
`
  ],
)
