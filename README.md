# Quirc bindings for Ruby

[Quirc](https://github.com/dlbeer/quirc) is a small C library for extracting and decode QR codes from images.
This project is a Ruby binding for that library with the library embedded.

## Example
You have to supply a [ChunkyPNG](http://chunkypng.com/) object or a byte string of the grayscale image with width and height.
```ruby
require 'chunky_png'
require 'quirc'

img = ChunkyPNG::Image.from_file('path_to_image.png')
res = Quirc.decode(img).first
puts res.payload
```

## License
This software is licensed under the MIT License. [View the license](LICENSE).
