# JTask.chop()
# Removes an entire key-value pair from one or all of the file's objects.
# ------------------------------------------------------------------------------
# Eg: JTask.chop("user_data.json", :all, "session_dump")
# #=> true
# ------------------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.chop()

require "json"
require "jtask/helpers"

class JTask
  def self.chop(filename, method, parameter, dir=nil)
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

    # Quality control - ensure parameter is a string
    unless parameter.is_a?(String)
      raise SyntaxError, "[JTask] The chop() method can only remove one parameter at a time - only a string can be used to specify the parameter."
    end

    # First off lets quickly make sure the file has at least one object
    unless objects.count > 0
      return false
    end

    if @method_type == :id
      id = method
      if objects["#{id}"]
        removed_version = objects["#{id}"].tap{ |object| object.delete(parameter) }
        objects["#{id}"] = removed_version
      else
        return false
      end
    elsif @method_type == :id_array
      method.each do |id|
        removed_version = objects["#{id}"].tap{ |object| object.delete(parameter) }
        objects["#{id}"] = removed_version
      end
    elsif @method_type == :first or @method_type == :last
      if @method_type == :first
        required_records = Hash[(objects.to_a).first(method[:first].to_i)]
      end

      if @method_type == :last
        required_records = Hash[(objects.to_a).last(method[:last].to_i).reverse]
      end

      id_array = Array.new
      required_records.each do |id, object|
        id_array << id
      end
      id_array.each do |id|
        removed_version = objects["#{id}"].tap{ |object| object.delete(parameter) }
        objects["#{id}"] = removed_version
      end
    elsif @method_type == :all
      objects.each do |k, v|
        objects["#{k}"] = objects["#{k}"].tap{ |object| object.delete(parameter) }
      end
    end

     # Re-write the file with the new version.
     File.write(File.join(dir, filename), objects.to_json)

    return true
  end
end