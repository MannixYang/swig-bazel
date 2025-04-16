def _swig_cpp_to_python(ctx):
    swig = ctx.executable.swig
    i_file = ctx.file.interface
    out_py = ctx.label.name + ".py"
    out_wrap = ctx.label.name + "_wrap.cxx"

    outputs = [ctx.actions.declare_file(out_py), ctx.actions.declare_file(out_wrap)]

    include_dirs = depset(
        direct = [f.dirname for f in ctx.files.lib_dir],
    )
    args = ctx.actions.args()
    args.add("-c++", "-python")

    for inc in include_dirs.to_list():
        args.add(str("-I") + inc)

    args.add("-o", outputs[1].path)
    args.add("-outdir", ctx.genfiles_dir.path + "/" + ctx.label.package)
    args.add("-module", ctx.label.name)

    args.add(i_file.path)

    ctx.actions.run(
        inputs = [i_file] + ctx.files.lib_dir,
        outputs = outputs,
        arguments = [args],
        executable = swig,
        mnemonic = "SwigGen",
        progress_message = "Generating SWIG interface for {}".format(i_file.short_path),
    )
    return DefaultInfo(files = depset(outputs))

swig_cpp_to_python = rule(
    implementation = _swig_cpp_to_python,
    attrs = {
        "interface": attr.label(allow_single_file = True, doc = "SWIG .i file"),
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
    },
    doc = "Generates Python bindings via SWIG",
)
