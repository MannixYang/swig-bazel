load("//generator:swig_cpp_to_python.bzl", "swig_cpp_to_python_binary")

swig_cpp_to_python_binary(
    name = "example",
    srcs = ["runme.py"],
    cpp_hdrs = [
        "example.h",
        "example_square.h",
    ],
    cpp_srcs = [
        "example.cxx",
        "example_square.cxx",
    ],
    main = "runme.py",
    module_name = "example",
    translator = "example.i",
)
