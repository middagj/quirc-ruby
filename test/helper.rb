# frozen_string_literal: true

require "zlib"

require "minitest/autorun"
require "oily_png"

require "quirc"

module TestHelpers
  def binary_fixture(*path)
    Zlib::Inflate.inflate(File.binread(File.join(__dir__, "fixtures", *path)))
  end

  def image_fixture(*path)
    ChunkyPNG::Image.from_file(File.join(__dir__, "fixtures", *path))
  end
end

module Minitest
  class Spec
    include TestHelpers
  end
end
