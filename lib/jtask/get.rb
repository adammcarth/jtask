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
require "./helpers"

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

    # Check the file exists
    unless File.exists?(File.join(dir, filename))
      raise NameError, "[JTask] Couldn't find the file specified at '#{dir}#{filename}'. Try running JTask.save(\"#{filename}\") to setup a blank file."
    end

    # Parse the file
    original_file = File.read(File.join(dir, filename))
    objects = JSON.parse(original_file)

    # Work out which retrieval method is wanted.
    @method_type = JTask::Helpers.verify_method(method)

    # First off lets quickly make sure the file has at least one object
    unless objects.count > 0
      return nil
    end

    # Method is a specific id (integer)
    if @method_type == :id
      # Our method will be the id - lets alias it:
      id = method
      if objects["#{id}"]
        output = JTask::Get.new({ "id" => id.to_i }.merge(objects["#{id}"]))
      else
        output = nil
      end
    # Method is an array of specific id's (integers)
    elsif @method_type == :id_array
      required_records = Hash.new
      method.each do |id|
        if objects["#{id}"]
          required_records["#{id}"] = objects["#{id}"]
        else
          output = nil
        end
      end
    # Method is a 'first: x' hash
    elsif @method_type == :first
      required_records = Hash[(objects.to_a).first(method[:first].to_i)]
    # Method is a 'last: x' hash
    elsif @method_type == :last
      required_records = Hash[(objects.to_a).last(method[:last].to_i).reverse] # grab a beer if you want
    # If method is the :all symbol OR no method supplied (all objects required)
    elsif @method_type == :all
      required_records = objects
    end

    # For methods where more than one hash is present, they still need to be processed into an array + ostruct.
    if required_records
      output = required_records.map { |id, record| JTask::Get.new({ "id" => id.to_i }.merge(record)) }
    end

    return output
  end
end