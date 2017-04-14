require "rake/extensiontask"
require "rake/testtask"

Rake::ExtensionTask.new("quirc") do |ext|
  ext.lib_dir = "lib/quirc"
  ext.config_options = "--with-cflags='-std=c99'"
end

Rake::TestTask.new do |t|
  t.libs << "test"
end

Rake::Task[:test].prerequisites << :compile

task default: :test
