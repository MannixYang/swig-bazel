def _swig_cpp_to_python(ctx):
    include_dirs = depset(
        direct = [f.dirname for f in ctx.files.lib_dir],
    )

    file_module_py = ctx.actions.declare_file(ctx.attr.module_name + ".py")
    file_wrap_cxx = ctx.outputs.wrap_cxx

    args = ctx.actions.args()
    args.add("-c++", "-python")

    for inc in include_dirs.to_list():
        args.add(str("-I") + inc)

    args.add("-o", file_wrap_cxx.path)
    args.add("-outdir", ctx.genfiles_dir.path + "/" + ctx.label.package)
    args.add("-module", ctx.attr.module_name)

    args.add(ctx.file.translator.path)

    ctx.actions.run(
        inputs = ctx.files.includes + [ctx.file.translator] + ctx.files.lib_dir,
        outputs = [file_module_py, file_wrap_cxx],
        arguments = [args],
        executable = ctx.executable.swig,
        mnemonic = "SwigGen",
        progress_message = "Generating SWIG interface for {}".format(ctx.files.translator),
    )
    return DefaultInfo(files = depset([file_module_py]))

swig_cpp_to_python = rule(
    implementation = _swig_cpp_to_python,
    attrs = {
        "includes": attr.label_list(allow_files = True, doc = "input C++ header files"),
        "translator": attr.label(allow_single_file = True, doc = "SWIG .i file"),
        "lib_dir": attr.label(
            default = Label("//:lib_python"),
            doc = "SWIG standard library filegroup",
            allow_files = True,
        ),
        "swig": attr.label(
            default = Label("//:swig"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "wrap_cxx": attr.output(mandatory = True),
        "module_name": attr.string(),
    },
    doc = "Generates Python bindings via SWIG",
)

def swig_cpp_to_python_binary(name, srcs, main, cpp_hdrs, cpp_srcs, translator, module_name, **kwargs):
    swig_cpp_to_python(
        name = name + "_py",
        includes = cpp_hdrs,
        translator = translator,
        wrap_cxx = name + "_wrap.cxx",
        module_name = module_name,
    )

    native.cc_library(
        name = "lib_" + name,
        hdrs = cpp_hdrs,
        srcs = cpp_srcs + [name + "_wrap.cxx"],
        deps = ["@cpython_windows//:embed"],
    )

    native.cc_shared_library(
        name = name + "_shared",
        shared_lib_name = "_" + name + ".pyd",
        deps = ["lib_" + name],
    )

    native.py_binary(
        name = name,
        srcs = [name + "_py"] + srcs,
        main = main,
        imports = ["."],
        data = [name + "_shared"],
        **kwargs
    )
