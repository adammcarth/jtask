# JTask.rename()
# Simply renames the file to something different.
# ----------------------------------------------------------------------------------
# Eg: JTask.rename("orders.json", "0r3erz.json")
# #=> true
# ----------------------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.rename()

class JTask
  def self.rename(filename, new_filename, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      if File.directory?("models/")
        dir = "models/"
      else
        raise RuntimeError, "[JTask] The directory 'models/' doesn't exist in your current location. Please create it or refer to the documentation on how to change your file path."
      end
    end

    # Rename the file
    File.rename(File.join(dir, filename), File.join(dir, new_filename))

    return true
  end
end