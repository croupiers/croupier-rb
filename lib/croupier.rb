require_relative 'croupier/version'
require_relative 'croupier/cli/trollop'
require_relative 'croupier/exceptions'
require_relative 'croupier/distribution_generator'
require_relative 'croupier/distribution_generators'
Dir[File.join(File.dirname(__FILE__), "./croupier/distribution_generators/*.rb")].each {|f| require f}
require_relative 'croupier/distribution'
require_relative 'croupier/distributions'
Dir[File.join(File.dirname(__FILE__), "./croupier/distributions/*.rb")].each {|f| require f}
require_relative 'croupier/cli/application'
#####################################################################
# Croupier module.
# Used as a namespace containing all the Croupier code.
# The module defines a Croupier::CLI::Application and interacts with the user output console.
#
module Croupier
  STDERR = $stderr
  STDOUT = $stdout

  # Croupier module singleton methods.
  #
  class << self
    # Current Croupier Application
    def application
      @application ||= ::Croupier::CLI::Application.new
    end

    # Set the current Croupier application object.
    def application=(app)
      @application = app
    end

    # Stops the execution of the Croupier application.
    def stop(msg = "Error: Croupier finished.")
      self.error_message msg
      exit(false)
    end

    # Writes message to the standard output
    def message(msg)
      STDOUT.puts msg
      STDOUT.flush
    end

    # Writes message to the error output
    def error_message(msg)
      STDERR.puts msg
      STDERR.flush
    end

    # Writes to the standard output
    def write(str)
      STDOUT.write str
      STDOUT.flush
    end

    # Clear current console line
    def clear_line!
      self.write "\r"
    end

    # Trap SIGINT signal
    def trap_interrupt
      trap('INT') do
        Croupier.stop("\nCroupier Exiting... Interrupt signal received.")
      end
    end

    ## Random generator related stuff.

    # Same as Random#rand applied to Croupier random object.
    #
    # @return random number x, 0 <= x < 1
    def rand *args
      random.rand *args
    end

    # Sets Croupier random generator to a new object
    # with provided seed.
    # If seed is omitted, a new Random object is created
    # without explicit seed.
    # @param seed [Numeric] optional seed
    # @return [NilClass] nil
    def srand(seed=nil)
      @random_generator = seed ? Random.new(seed) : Random.new
      nil
    end

    # Croupier Random object
    #
    # @return [Random] croupier random object
    def random
      @random_generator ||= Random.new
    end

    # Croupier Random object seed.
    #
    # @return [Numeric] croupier random object seed
    def seed
      random.seed
    end

    # Croupier Warn
    #
    # @param *args [String[,String...]] messages
    # @return NilClass
    def warn *args
      if @warn
        args.each {|m| message m }
      end
    end

    # Activates warning messages (activated by default)
    def activate_warnings
      @warn = true
    end

    # Deactivates warning messages
    def deactivate_warnings
      @warn = false
    end

    def warn?
      @warn = true if @warn.nil?
      @warn
    end
  end
end
