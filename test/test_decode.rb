# frozen_string_literal: true

require "helper.rb"

describe Quirc do
  describe "binary string" do
    it "should decode" do
      result = Quirc.decode(binary_fixture("hello.gz"), 44, 44).first
      assert_equal 1, result.ecc_level
      assert_equal "Hello World!", result.payload
    end
  end

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
      e = assert_raises ArgumentError do
        Quirc::Decoder.new(1, 2).decode("abc")
      end
      assert_equal "Decoder is allocated for 1x2 images", e.message
    end

    it "should throw error if width is not specified with binary string" do
      e = assert_raises ArgumentError do
        Quirc.decode("", nil, 1)
      end
      assert_equal "Arguments width and height are required if binary string is passed", e.message
    end

    it "should throw error if width height not specified with binary string" do
      e = assert_raises ArgumentError, "Decoder is allocated for 1x2 images" do
        Quirc.decode("", nil, 1)
      end
      assert_equal "Arguments width and height are required if binary string is passed", e.message
    end
  end
end
