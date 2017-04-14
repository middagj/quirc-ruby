# frozen_string_literal: true

require "helper.rb"

describe Quirc do
  describe "error levels" do
    it "should decode all error levels" do
      %i[m l h q].each_with_index do |level, no|
        image = image_fixture("hello-120-utf8-#{level}.png")
        result = Quirc.decode(image).first
        assert_equal no, result.ecc_level
        assert_equal "Hello World!", result.payload
      end
    end
  end

  describe "errors" do
    it "should throw error if image size is not equal to buffer" do
      assert_raises ArgumentError, "Decoder is allocated for 1x2 images" do
        Quirc::Decoder.new(1, 2).decode("abc")
      end
    end
  end
end
