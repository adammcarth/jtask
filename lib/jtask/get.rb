# JTask.get()
# Retrieves stored JSON data from the file and returns an OpenStruct.
# --------------------------------------------------------------------------------
# Eg: JTask.get("test.json", 1) || JTask.get("test.json", first: 10)
# #=> <OpenStruct id=x, ...>
# --------------------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.get()

require "json"
require "ostruct"
require "jtask/helpers"

class JTask
  # Allows nested OpenStructs, refer to http://andreapavoni.com/blog/2013/4/create-recursive-openstruct-from-a-ruby-hash
  # Credits: Andrea Pavoni (DeepStruct guru)
  class Get < OpenStruct
    def initialize(hash=nil)
      @table = {}
      @hash_table = {}
      if hash
        hash.each do |k,v|
          @table[k.to_sym] = (v.is_a?(Hash) ? self.class.new(v) : v)
          @hash_table[k.to_sym] = v
          new_ostruct_member(k)
        end
      end
    end
    def to_h
      @hash_table
    end
  end
end

class JTask
  def self.get(filename, method=nil, dir=nil)
    # Set the directory
    dir = JTask::Helpers.set_directory(dir)

    # Parse the file
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
        output = JTask::Get.new({ "id" => id.to_i }.merge(objects["#{id}"]))
      else
        # id supplied doesn't exist
        raise NameError, "[JTask] The id #{id} could not be found in the file \"#{dir + filename}\"."
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
      output = required_records.map { |id, record| JTask::Get.new({ "id" => id.to_i }.merge(record)) }
    end

    return output
  end
end