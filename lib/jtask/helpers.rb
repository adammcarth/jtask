require "jtask/config"

class JTask
  module Helpers

    # This helper determines if a custom directory has been passed to the current JTask
    # method eg - JTask.get("orders.json", 4, "my/custom/dir/"). If this is the case,
    # the custom directory is outputted. If not, the default directory is outputted.
    def self.set_directory(custom_directory=nil)
      # Check if user has specified a custom directory in the method
      if custom_directory
        # Yes they have, let's use it.
        dir = custom_directory
      else
        # No, let's load the default directory.
        dir = JTask.configuration.file_dir
      end

      # Now that we have a working directory set in a variable called "dir",
      # let's test to see if it exists or not (so we can output a friendly error if it doesn't!).
      unless File.directory?(dir)
        # Panic since the directory doesn't exist. Literally.
        raise RuntimeError, "[JTask] The directory '#{dir}' doesn't exist in your current location. Please create it or refer to the documentation on how to change your file path."
      end

      # Output the directory we need to use.
      return dir
    end

    # JTask's "method" parameter can take a number of different forms:
    #   - Integer (target a single id)
    #   - Array (eg - [1, 5, 9] to target multiple ids)
    #   - Key-value pair ('first: x' or 'last: x' ONLY)
    #   - Symbol (':all' ONLY)
    # This helper determines which one has been passed to JTask, and also validates
    # the method's authenticity. If no errors are raised, a string is outputted containing either
    # "id", "id_arr", "first", "last" or "all" so we can perform the required action in the method.
    def self.verify_method(method=nil)
      # No method was passed to JTask (eg - JTask.get("orders.json") should get all orders)
      if !method
        output = "all"

      # Single id given
      elsif method.is_a?(Integer)
        output = "id"

      # Array of ids
      elsif method.is_a?(Array)
        # Make sure the array only contains integers
        method.each do |id|
          unless id.is_a?(Integer)
            raise SyntaxError, "[JTask] The method array may only contain integers."
          end
        end

        output = "id_arr"

      # first: x, last:x hash given.
      elsif method.is_a?(Hash)
        # Ensure that 'first' or 'last' have been used.
        if method[:first]
          output = "first"
        elsif method[:last]
          output = "last"
        else
          # Invalid hash supplied
          raise NameError, "[JTask] Your method hash must look like { first/last: int }."
        end

        # Ensure an integer has been used as the value of the hash.
        unless method[:first].is_a?(Integer) or method[:last].is_a?(Integer)
          raise SyntaxError, "[JTask] Your first/last method hash may only contain an integer as the value."
        end

      # :all records required
      elsif method.is_a?(Symbol)
        # Ensure only ':all' has been used.
        if method == :all
          output = "all"
        else
          # Invalid symbol supplied
          raise NameError, "[JTask] The only symbol which may be used as a method is ':all'."
        end

      # Something unrecognisable (probably a string) has been used incorrectly.
      else
        raise NameError, "[JTask] Invalid value passed to the method parameter."
      end

      # Output the method type
      return output
    end

  end
end