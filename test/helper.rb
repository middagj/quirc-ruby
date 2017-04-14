# frozen_string_literal: true

require "minitest/autorun"
require "oily_png"
require "quirc"

module TestHelpers
  def image_fixture(*path)
    ChunkyPNG::Image.from_file(File.join(__dir__, "fixtures", *path))
  end
end

class Minitest::Spec
  include TestHelpers
end
