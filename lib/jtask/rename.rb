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
    # Set the directory
    dir = JTask::Helpers.set_directory(dir)

    # Rename the file
    File.rename(File.join(dir, filename), File.join(dir, new_filename))

    return true
  end
end