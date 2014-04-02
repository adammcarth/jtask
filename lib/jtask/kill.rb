# JTask.kill()
# Completely removes the entire file specified from the system.
# -----------------------------------------------------------------------------
# Eg: JTask.kill("users.json.bak")
# #=> true
# -----------------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.kill()

class JTask
  def self.kill(filename, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      if File.directory?("models/")
        dir = "models/"
      else
        raise RuntimeError, "[JTask] The directory 'models/' doesn't exist in your current location. Please create it or refer to the documentation on how to change your file path."
      end
    end

    # Delete the file
    File.delete(File.join(dir, filename))

    return true
  end
end