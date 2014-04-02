# JTask.get() by Adam McArthur
# Retrieves stored JSON data from the file and returns a hash.

class JTask
  def self.get(filename, method=nil, dir=nil)
    # Check if user has specified a custom directory.
    unless dir
      # If not, a default folder is assigned.
      if File.directory?("models/")
        dir = "models/"
      else
        raise RuntimeError, "[JTask] The directory 'models/' doesn't exist in your current location. Please create it or refer to the documentation on how to change your file path."
      end
    end
    original_file = File.read(File.join(dir, filename))
    objects = JSON.parse(original_file)

    # Work out which retrieval method is wanted.
    # An integer indicates we want to find a single record by id.
    # A hash indicates the first/last method has been used.

    # Check for integer
    if method.is_a?(Integer)
      # Our method will be the id - lets alias it:
      id = method

      if objects["#{id}"]
        output = OpenStruct.new({ "id" => id.to_i }.merge(objects["#{id}"]))
      else
        # id supplied doesn't exist
        raise NameError, "[JTask] The id #{method} could not be found in the file \"#{dir + filename}\"."
      end
    else
      # Method could be either blank, invalid or a "first/last" hash.
      begin
        # Treat method as a hash
        # Assemble hashes of the required records, as specified by the user.
        if method[:first]
          required_records = Hash[(objects.to_a).first(method[:first].to_i)]
        elsif method[:last]
          required_records = Hash[(objects.to_a).last(method[:last].to_i).reverse] # wow!
        end
      # Rescue to prevent '[]' nil class error if method is empty
      rescue
        if method == nil
          # We want all the records since no get method is supplied
          required_records = objects
        else
          # Unrecognisable value used as the method, crash immediatly.
          raise SyntaxError, "[JTask] Invalid value given for the get method."
        end
      end
      # Loop through each required record and
      # assemble each key-value into the open structure output.
      # Map all openstructs to an array.
      output = required_records.map { |id, record| OpenStruct.new({ "id" => id.to_i }.merge(record)) }
    end

    return output
  end
end