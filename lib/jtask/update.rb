module Update
  def update(filename, id, parameters, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      dir = "models/"
    end
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