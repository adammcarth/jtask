# JTask.destroy()
# Removes an entire object from the file.
# ------------------------------------------------------------------
# Eg: JTask.destroy("orders.json", 5)
# #=> true
# ------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.destroy()

require "json"
require "./helpers"

class JTask
  def self.destroy(filename, method=nil, dir=nil)
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
      return false
    end

    # Make sure they want to delete everything if no method is used
    if !method
      raise ArgumentError, "[JTask] Are you sure you wish to delete all objects from the file? Shorthand is disabled for this method - please use ':all' as the method parameter to confirm your action."
    end

    if @method_type == :id
      id = method
      if objects["#{id}"]
        new_version = objects.tap { |object| object.delete("#{id}") }
      else
        return false
      end
    elsif @method_type == :id_array
      method.each do |id|
        new_version = objects.tap { |object| object.delete("#{id}") }
      end
    elsif @method_type == :first
      required_records = Hash[(objects.to_a).first(method[:first].to_i)]
    elsif @method_type == :last
      required_records = Hash[(objects.to_a).last(method[:last].to_i).reverse]
    elsif @method_type == :first or @method_type == :last
      id_array = Array.new
      required_records.each do |id, object|
        id_array << id
      end
      id_array.each do |id|
        new_version = objects.tap { |object| object.delete("#{id}") }
      end
    elsif @method_type == :all
      new_version = "{}"
    end

    # Delete the object with id n from the objects hash


    # Re-write the file with the new version.
    File.write(File.join(dir, filename), new_version.to_json)

    return true
  end
end