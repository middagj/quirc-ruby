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
  eJx9lF2OhDAMg/cQPVceeg/ExeGxfWR3rU9W+sMMEmKYhMRxXD+9DVd/fv+v
  p/eHe471sw7X2ZXbz7Nzz7FWS/gtSm2q12pt3HOs1bjc5YraVC9z55j+A9dY
  L6774Js1Bq6xXonjJr7Hfv4vf8dMzh1j67u5MobvuSv2z7nf8O1xYuZu/Xbu
  S653MsdWvkvk/vbYusfc3xzb9aH/jlucrbFVd2C8D+1ijekdtUq37ODpV8Tl
  XOdIq6oudPxWvX5GKWEMPBUXR6gqc5lJOf5Gk5GLqhIDXKm3sYgZ5YpP/cM5
  s3bREP38hE914pxZu2iTfvlMvcLrqF2wJKbUK7yO2mVGP2FWWLQDZgGLcHvv
  aARmyTVHzCjc1kxqJP1DddDWfcBp+kpiMG5xom0dN5ymX+36sA7FiDBkJnud
  NWkM8JcI2NusZzbFTNaKKuznxN3gylpRxd2zUNAVnGVxCHPOHc81E0ThLGs3
  bAQMq++IWe80T++bv0k/qobnp0O/+Zu1gHqTmU8+ydR0MDNvfmYW0tnNzO5n
  ZiGd3cx88jN7GlOqD/y++Zn1CnvqwxmYtTPqdYyhktWz3vUqLv4AZ3HyYg==
EOD

img = Zlib::Inflate.inflate(Base64.decode64(encoded))
res = Quirc.decode(img, 44, 44).first
puts res.payload
```

## License
This software is licensed under the MIT License. [View the license](LICENSE).
