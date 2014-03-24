module Destroy
  def destroy(filename, id, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      dir = "models/"
    end
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