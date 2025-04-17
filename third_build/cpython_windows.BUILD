load("@rules_license//rules:license.bzl", "license")

package(
    default_applicable_licenses = [":license"],
    default_visibility = ["//visibility:public"],
)

license(
    name = "license",
    package_name = "python-build-standalone",
    license_kinds = [
        "@rules_license//licenses/spdx:BSD-3-Clause",
    ],
    license_text = "LICENSE.txt",
)

# To build Python C/C++ extension on Windows, we need to link to python import library `pythonXY.lib`.
# See: https://docs.python.org/3/extending/windows.html

cc_import(
    name = "lib",
    interface_library = "libs/python312.lib",
    shared_library = "python312.dll",
)

filegroup(
    name = "public_hdrs",
    srcs = glob([
        "include/*",
        "include/cpython/*",
    ]),
)

filegroup(
    name = "internal_hdrs",
    srcs = glob(["include/internal/*"]),
)

filegroup(
    name = "if_lib_files",
    srcs = [
        "libs/_tkinter.lib",
        "libs/python3.lib",
        "libs/python312.lib",
    ],
)

filegroup(
    name = "lib_files",
    srcs = [
        # "python.exe",
        "python3.dll",
        "python312.dll",
        # "pythonw.exe",
        "vcruntime140.dll",
        "vcruntime140_1.dll",
    ],
)

filegroup(
    name = "module_files",
    srcs = glob(
        [
            "DLLs/**",
            "Lib/**",
            "Scripts/**",
        ],
        exclude = [
            "**/*.pdb",
            "**/test/**",
            "**/__pycache__/**",
            # Space in filenames will cause the build-runfiles failed, so we drop the unnecessnary files.
            # See: https://github.com/bazelbuild/bazel/issues/4327
            # Alternatively, we can use build option `--experimental_inprocess_symlink_creation`.
            "**/* *",
        ],
    ),
)

cc_library(
    name = "embed",
    srcs = [":internal_hdrs"],
    hdrs = [":public_hdrs"],
    data = [":module_files"],
    linkstatic = True,
    strip_include_prefix = "include",
    deps = [":lib"],
)
