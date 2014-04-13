require "bundler/setup"
Bundler.setup

require "jtask/config"
JTask.configure do |config|
  config.file_dir = "spec/test_files"
end

require "fileutils"