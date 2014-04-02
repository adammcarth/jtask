require "jtask/config"

class JTask
  module Helpers
    def self.set_directory(custom_directory=nil)
      # Check if user has specified a custom directory in the method
      if custom_directory
        # Yes, lets use it.
        dir = custom_directory
      else
        # No, lets load the default directory.
        dir = JTask.configuration.file_dir
      end

      # Panic if the directory doesn't exist. Literally.
      unless File.directory?(dir)
        raise RuntimeError, "[JTask] The directory '#{dir}' doesn't exist in your current location. Please create it or refer to the documentation on how to change your file path."
      end

      return dir
    end
  end
end