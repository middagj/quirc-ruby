# frozen_string_literal: true

require "mkmf"

ROOT = File.expand_path(File.join(__dir__, "..", ".."))
SRC_DIR = File.join(__dir__, "embed")
TMP_DIR = File.join(ROOT, "tmp", RUBY_PLATFORM)
BUILD_DIR = File.join(TMP_DIR, "quirc-1.0")
LIB_FILE = File.join(BUILD_DIR, "libquirc.a")

def build_library
  FileUtils.makedirs(BUILD_DIR)
  system({ "BUILD_DIR" => BUILD_DIR }, "make", "-C", SRC_DIR) or raise "Error building quirc"
end

find_header("quirc.h", "#{SRC_DIR}/lib") or missing("quirc.h")
build_library
$LOCAL_LIBS << LIB_FILE

create_makefile("quirc/quirc")
