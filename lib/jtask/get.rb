module Get
  def get(filename, method=nil, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      dir = "models/"
    end
    original_file = File.read(File.join(dir, filename))
    objects = JSON.parse(original_file)
    
    if method
      # Determine if an id integer or {first: - last:} hash method has been supplied.
      if method.is_a?(Integer)
        # Check if 'method' (in this case the single id to retrieve) exists.
        if objects["#{method}"]
          output = {"id" => "#{method}"}.merge(objects["#{method}"])
        else
          # id supplied doesn't exist
          raise NameError, "[JTask] The id #{method} could not be found in the file \"#{dir + filename}\"."
        end
      elsif method.is_a?(Hash)
        if method[:first]
          # Load the FIRST n number of objects from the file
          output = Hash[(objects.to_a).first(method[:first].to_i)]
        elsif method[:last]
          # Load the LAST n number of objects from the file
          output = Hash[(objects.to_a).last(method[:last].to_i).reverse] # wow!
        else
          raise NameError, "[JTask] Invalid get method specified. Try using JTask.get(\"filename\", last: 10) instead." 
        end
      else
        raise NameError, "[JTask] Invalid get method specified. Try using JTask.get(\"filename\", 1) instead."
      end
    else
      # No retrieval method supplied, so output all the objects from the file :)
      output = objects
    end
    
    return output
  end
end