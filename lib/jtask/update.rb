# JTask.update()
# Updates an existing JSON object with a new set of values.
# ----------------------------------------------------------------------
# Eg: JTask.update("clients.json", 4, new: "value")
# #=> true
# ----------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.update()

require "json"
require "jtask/helpers"

class JTask
  def self.update(filename, id, parameters, dir=nil)
    # Set the directory
    dir = JTask::Helpers.set_directory(dir)

    # Parse the file
    original_file = File.read(File.join(dir, filename))
    objects = JSON.parse(original_file)

    insert = objects
    parameters.each do |k, v|
      # Update (or add) each parameter
      insert["#{id}"][k.to_s] = v
    end

    # Re-write the file with the new version.
    File.write(File.join(dir, filename), insert.to_json)

    return true
  end
end