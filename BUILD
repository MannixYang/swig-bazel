# See https://github.com/google/or-tools/blob/v9.9/bazel/swig.BUILD.bazel

licenses(["restricted"])  # GPLv3

exports_files(["LICENSE"])

config_setting(
    name = "on_windows",
    constraint_values = ["@platforms//os:windows"],
)

cc_binary(
    name = "swig",
    srcs = glob([
        "Source/**/*.h",
        "Source/**/*.c",
        "Source/**/*.cxx",
    ]),
    copts = ["$(STACK_FRAME_UNLIMITED)"] + select({
        "on_windows": [],
        "//conditions:default": [
            "-Wno-parentheses",
            "-Wno-unused-variable",
            "-fexceptions",
        ],
    }),
    includes = [
        "Source/CParse",
        "Source/DOH",
        "Source/Doxygen",
        "Source/Include",
        "Source/Modules",
        "Source/Preprocessor",
        "Source/Swig",
    ],
    output_licenses = ["unencumbered"],
    visibility = ["//visibility:public"],
    deps = ["@pcre2"],
)

filegroup(
    name = "lib_python",
    srcs = glob([
        "Lib/*",
        "Lib/python/*",
        "Lib/std/*",
        "Lib/typemaps/*",
    ]),
    licenses = ["notice"],  # simple notice license for Lib/
    path = "Lib",
    visibility = ["//visibility:public"],
)
