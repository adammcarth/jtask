module Rename
  def rename(filename, new, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      dir = "models/"
    end
    
    # Rename the file
    File.rename(File.join(dir, filename), File.join(dir, new))

    return true
  end
end