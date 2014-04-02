# JTask::Convert
# Prepares existing json files to be manipulated by JTask's methods.
# -----------------------------------------------------------------------------------
# Eg: JTask::Convert.json_file("wordpress_users_export.json")
# #=> true
# -----------------------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask::Convert

require "json"
require "jtask/rename"
require "jtask/save"

class JTask
  module Convert
    def self.json_file(filename, dir=nil)
      # Check if user has specified a custom directory.
      unless dir
        # If not, a default folder is assigned.
        if File.directory?("models/")
          dir = "models/"
        else
          raise RuntimeError, "[JTask] The directory 'models/' doesn't exist in your current location. Please create it or refer to the documentation on how to change your file path."
        end
      end
      original_file = File.read(File.join(dir, filename))
      objects = JSON.parse(original_file)

      output = Hash.new
      objects.each_with_index do |(k, v), n|
        output["#{n + 1}"] = {k => v}
      end

      # Rename the old version
      begin
        JTask.rename(filename, "#{filename}.old", dir)
      rescue
        raise RuntimeError, "[JTask] Failed to backup original file, conversion aborted."
      end

      # Write the new version
      begin
        JTask.save(filename, output, dir)
      rescue
        raise RuntimeError, "[JTask] Failed to save the converted file. The original can be found at '#{dir}#{filename}.old'"
      end

      return true
    end
  end
end

# JTask::Convert.json_file("orders.json")