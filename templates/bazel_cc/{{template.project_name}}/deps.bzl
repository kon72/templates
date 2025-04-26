load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _non_module_deps_impl(module_ctx = None):
    _unused = [module_ctx]  # buildifier: disable=unused-variable

    http_archive(
        name = "perfetto",
        build_file = "//third_party:perfetto.BUILD.bazel",
        integrity = "sha256-CHGpKhYqxWVbfXJPk1mxWnXE6SRycW7bxCJ6ZKRoC+Q=",
        strip_prefix = "perfetto-49.0",
        urls = ["https://github.com/google/perfetto/archive/refs/tags/v49.0.tar.gz"],
    )

non_module_deps = module_extension(
    implementation = _non_module_deps_impl,
)
