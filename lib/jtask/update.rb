# JTask.update()
# Updates an existing JSON object with a new set of values.
# ----------------------------------------------------------------------
# Eg: JTask.update("clients.json", 4, new: "value")
# #=> true
# ----------------------------------------------------------------------
# See wiki guide for more usage examples...
# https://github.com/adammcarthur/jtask/wiki/JTask.update()

require "json"
require "./helpers"

class JTask
  def self.update(filename, method, parameters, dir=nil)
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

    if @method_type == :id
      id = method
      if objects["#{id}"]
        parameters.each do |k, v|
          objects["#{id}"][k.to_s] = v
        end
      else
        return false
      end
    elsif @method_type == :id_array
      method.each do |id|
        parameters.each do |k, v|
          objects["#{id}"][k.to_s] = v
        end
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
        parameters.each do |k, v|
          objects["#{id}"][k.to_s] = v
        end
      end
    elsif @method_type == :all
      objects.each do |id, record|
        parameters.each do |k, v|
          objects["#{id}"][k.to_s] = v
        end
      end
    end

    # Re-write the file with the new version.
    File.write(File.join(dir, filename), objects.to_json)

    return true
  end
end