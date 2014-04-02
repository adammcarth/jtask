# JTask.kill()
# Completely removes the entire file specified from the system.
# -----------------------------------------------------------------------------
# Eg: JTask.kill("users.json.bak")
# #=> true
# -----------------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.kill()

require "jtask/helpers"

class JTask
  def self.kill(filename, dir=nil)
    # Set the directory
    dir = JTask::Helpers.set_directory(dir)

    # Delete the file
    File.delete(File.join(dir, filename))

    return true
  end
end