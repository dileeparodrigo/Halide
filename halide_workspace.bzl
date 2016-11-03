load("//:tools/llvm_repository.bzl", "llvm_repository")

def _check_version(x):
  if native.bazel_version < x:
    fail("Current Bazel version is {}, expected at least {}".format(native.bazel_version, x))

def halide_workspace():
  _check_version("0.4.0")

  # For external dependencies that rarely change, prefer http_archive over git_repository.
  native.new_http_archive(
    name = "zlib_archive",
    url = "http://zlib.net/zlib-1.2.8.tar.gz",
    sha256 = "36658cb768a54c1d4dec43c3116c27ed893e88b02ecfcb44f2166f9c0b7f2a0d",
    strip_prefix = "zlib-1.2.8",
    build_file = "//tools:zlib.BUILD",
  )

  native.new_http_archive(
    name = "png_archive",
    url = "https://github.com/glennrp/libpng/archive/v1.2.53.zip",
    sha256 = "c35bcc6387495ee6e757507a68ba036d38ad05b415c2553b3debe2a57647a692",
    build_file = "//tools:png.BUILD",
    strip_prefix = "libpng-1.2.53",
  )

  llvm_repository()