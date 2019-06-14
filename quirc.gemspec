require_relative "lib/quirc/version"

Gem::Specification.new do |s|
  s.name        = "quirc"
  s.version     = Quirc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = "Jacob Middag"
  s.email       = "jacob@gaddim.nl"
  s.homepage    = "https://github.com/middagj/quirc-ruby"
  s.summary     = "QR decoder based on quirc"
  s.description = "Ruby bindings for C library quirc that extracts and decode QR images"
  s.license     = "MIT"

  s.files       = `git ls-files -z -- README.md LICENSE ext lib vendor`.split("\0")
  s.test_files  = `git ls-files -z -- test`.split("\0")

  s.required_ruby_version = ">= 2.3"
  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "oily_png", "~> 1.0"
  s.add_development_dependency "rake-compiler", "~> 1.0"
  s.add_development_dependency "rubocop", "~> 0.71"

  s.extensions << "ext/quirc/extconf.rb"
end
