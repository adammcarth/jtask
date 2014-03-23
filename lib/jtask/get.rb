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
          # Old objects.select { |k, v| k == "#{method}" }
        else
          # id supplied doesn't exist
          raise NameError, "\n\nJTask Error => The id #{method} could not be found in\n               the file \"#{dir + filename}\".\n\n-"
        end
      elsif method.is_a?(Hash)
        if method[:first]
          # Load the FIRST n number of objects from the file
          output = Hash[(objects.to_a).first(method[:first].to_i)]
        elsif method[:last]
          # Load the LAST n number of objects from the file
          output = Hash[(objects.to_a).last(method[:last].to_i).reverse] # wow!
        else
          raise NameError, "\n\nJTask Error => Invalid get method specified. Try using\n               JTask.get(\"filename\", last: 10) instead.\n\n-" 
        end
      else
        raise NameError, "\n\nJTask Error => Invalid get method specified. Try using\n               JTask.get(\"filename\", 1) instead.\n\n-"
      end
    else
      # No retrieval method supplied, so output all the objects from the file :)
      output = objects
    end
    
    return output
  end
end