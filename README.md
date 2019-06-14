# Quirc bindings for Ruby

[Quirc](https://github.com/dlbeer/quirc) is a small C library for extracting and decode QR codes from images.
This project is a Ruby binding for that library with the library embedded.

## Example
You have to supply a [ChunkyPNG](http://chunkypng.com/) object or a binary string of the grayscale image with width and height.
```ruby
require 'chunky_png'
require 'quirc'

img = ChunkyPNG::Image.from_file('path_to_image.png')
res = Quirc.decode(img).first
puts res.payload
```

```ruby
require 'base64'
require 'zlib'
require 'quirc'

encoded = <<~EOD
  eJzt0kEOwyAMRNHe/9LpFo1mwK1IYqQ/mwQDfl5wXYQQQgghT+cziZ7Tb+Ue
  7vvurL76Vvvhvuvqu0jvqHoP9wx3dh73fHdWxz3Hrc5TvYfbx01RP83j7uH2
  cCtzuf+7g7uvr74ZrY9r967cedxebrrjZtK9tMbt4Y7+L/V/Tdzn3DRH+td5
  0hq3h5veR+qjNTcPbh+3Mpd7Qzt6497vat+Voe9Oa7j93GpdrXGt+7i9XO3j
  +jknzYB7huvmGM+7GXHPcWeOM3B7upV5Rlvvun3cHm6K+qt5qibucy4hhBBC
  yN58AXWDGDc=
EOD

img = Zlib::Inflate.inflate(Base64.decode64(encoded))
res = Quirc.decode(img, 44, 44).first
puts res.payload
```

## License
This software is licensed under the MIT License. [View the license](LICENSE).
