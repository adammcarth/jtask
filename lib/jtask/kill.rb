module Kill
  def kill(filename, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      dir = "models/"
    end

    # Delete the file
    File.delete(File.join(dir, filename))
    
    return true
  end
end