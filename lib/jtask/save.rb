# JTask.save()
# Saves a hash of parameters to the requested file.
# --------------------------------------------------------------------
# Eg: JTask.save("hello.json", {fname: "Adam", lname: "McArthur"})
# #=> true
# --------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.save()

require "json"

class JTask
  def self.save(filename, parameters, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      if File.directory?("models/")
        dir = "models/"
      else
        raise RuntimeError, "[JTask] The directory 'models/' doesn't exist in your current location. Please create it or refer to the documentation on how to change your file path."
      end
    end
    # Check if the file already exists
    unless File.exists?(File.join(dir, filename))
      # Create the file since it doesn’t exist, and setup up for JSON.
      File.open(File.join(dir, filename), "w+") { |file| file.write("{}") }
    end
    # Validate haash supplied for parameters
    unless parameters.is_a?(Hash)
      raise SyntaxError, "[JTask] Invalid value supplied to the parameters variable. Ensure your parameters are in the symbol hash form, eg - {name: \"Adam\", city: \"Melbourne\"}"
    end

    original_file = File.read(File.join(dir, filename))
    objects = JSON.parse(original_file)
    # Set the id of the new object
    if (objects.to_a).first
      # Add 1 to last object id
      nextid = (objects.to_a).last[0].to_i + 1
    else
      # No current objects exist yet, so set the id to 1
      nextid = 1
    end

    # Remove last character "}" from file.
    insert = File.read(File.join(dir, filename))[0..-2]

    insert << "," if (objects.to_a).first # add a comma if at least one object already exists
    insert << "\"#{nextid.to_s}\":"
    insert << parameters.to_json
    # Extra } used to replace the one we took out originally
    insert << "}"
    # Re-write the file with the new version.
    File.write(File.join(dir, filename), insert)

    return true
  end
end