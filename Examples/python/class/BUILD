load("//generator:swig_cpp_to_python.bzl", "swig_cpp_to_python_library")

swig_cpp_to_python_library(
    name = "example_cpp",
    srcs = [
        "example.cxx",
        "example_square.cxx",
    ],
    hdrs = [
        "example.h",
        "example_square.h",
    ],
    module_name = "example",
    translator = "example.i",
)

py_binary(
    name = "example",
    srcs = ["runme.py"],
    main = "runme.py",
    deps = [":example_cpp"],
)
