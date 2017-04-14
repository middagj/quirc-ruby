# frozen_string_literal: true

module Quirc
  def self.decode(image, width=nil, height=nil)
    width ||= image.public_send(:width)
    height ||= image.public_send(:height)
    if image.respond_to?(:to_grayscale_stream)
      Decoder.new(width, height).decode(image.to_grayscale_stream)
    else
      Decoder.new(width, height).decode(image)
    end
  end
end

require "quirc/version"
require "quirc/quirc"
