module Chop
  def chop(filename, id, parameter, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      dir = "models/"
    end
    original_file = File.read(File.join(dir, filename))
    objects = JSON.parse(original_file)

    # Quality control - ensure paramter is a string
    unless parameter.is_a?(String)
      raise SyntaxError, "[JTask] The chop() method can only remove one parameter at a time - only a string can be used to specify the parameter."
    end

    if id.is_a?(Integer)
      if objects["#{id}"]
        # Find object with the id and delete the requested parameter
        removed_version = objects["#{id}"].tap{ |x| x.delete(parameter) }
        insert = objects
        insert["#{id}"] = removed_version
      else
        raise NameError, "[JTask] The id #{method} could not be found in the file \"#{dir + filename}\". The file has not been changed."
      end
    elsif id == :all
      # Parameter must be removed from all objects
      objects.each do |k, v|
        # Remove parameter from every hash
        objects["#{k}"] = objects["#{k}"].tap{ |x| x.delete(parameter) }
      end
    insert = objects
    else
      raise NameError, "[JTask] Incorrect id method used. A single id (integer) can be specified, or the symbol \":all\" to remove the parameter from every object."
    end

     # Re-write the file with the new version.
     File.write(File.join(dir, filename), insert.to_json)

    return true
  end
end