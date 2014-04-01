class JTask
  # Provides configuration options for JTask.
  # Included in `lib/jtask.rb`.
  class Configuration
    # Used to set the default directory JTask looks in for files.
    attr_accessor :file_dir

    def initialize
      self.file_dir = "models/"
    end
  end

  # Allow options to be set under the JTask namespace.
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    # Update Configuration with new values if config the block is given.
    yield(configuration) if block_given?
  end
end