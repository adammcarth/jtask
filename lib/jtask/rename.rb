module Rename
  def rename(filename, new, dir=nil)
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
    File.rename(File.join(dir, filename), File.join(dir, new))

    return true
  end
end