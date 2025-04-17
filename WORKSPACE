workspace(name = "swig")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "cpython_windows",
    build_file = "//third_build:cpython_windows.BUILD",
    sha256 = "facfaa1fbc8653f95057f3c4a0f8aa833dab0e0b316e24ee8686bc761d4b4f8d",
    strip_prefix = "python",
    url = "https://github.com/indygreg/python-build-standalone/releases/download/20231002/cpython-3.12.0+20231002-x86_64-pc-windows-msvc-shared-install_only.tar.gz",
)
