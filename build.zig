const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "example_glfw_metal",
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    exe.addCSourceFiles(&.{
        "imgui.cpp",
        "imgui_demo.cpp",
        "imgui_draw.cpp",
        "imgui_tables.cpp",
        "imgui_widgets.cpp",
        "backends/imgui_impl_glfw.cpp",
        "backends/imgui_impl_metal.mm",
        "examples/example_glfw_metal/main.mm",
    }, &.{});
    exe.linkLibCpp();
    exe.linkFramework("Metal");
    exe.linkFramework("MetalKit");
    exe.linkFramework("Cocoa");
    exe.linkFramework("IOKit");
    exe.linkFramework("CoreVideo");
    exe.linkFramework("QuartzCore");
    exe.linkFramework("CoreVideo");
    exe.addLibraryPath("/opt/homebrew/lib");
    exe.linkSystemLibraryName("glfw");
    exe.addSystemIncludePath("/opt/homebrew/include");
    exe.addIncludePath(".");
    exe.addIncludePath("backends");

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run example");
    run_step.dependOn(&run_exe.step);
}
