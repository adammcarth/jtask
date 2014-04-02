# JTask.destroy()
# Removes an entire object from the file.
# ------------------------------------------------------------------
# Eg: JTask.destroy("orders.json", 5)
# #=> true
# ------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.destroy()

require "json"
require "jtask/helpers"

class JTask
  def self.destroy(filename, id, dir=nil)
    # Set the directory
    dir = JTask::Helpers.set_directory(dir)

    # Parse the file
    original_file = File.read(File.join(dir, filename))
    objects = JSON.parse(original_file)

    if objects["#{id}"]
      # Delete the object with id n from the objects hash
      insert = objects.tap{ |x| x.delete("#{id}") }
    else
      # the id doesn't exist in the file
      raise NameError, "[JTask] An id of #{id} does not exsist in the file specified at \"#{dir + filename}\". Nothing has been deleted."
    end

    # Re-write the file with the new version.
    File.write(File.join(dir, filename), insert.to_json)

    return true
  end
end