require 'croupier/version'
require 'croupier/cli/trollop'
require 'croupier/exceptions'
require 'croupier/distribution'
require 'croupier/distributions'
Dir[File.join(File.dirname(__FILE__), "./croupier/distributions/*.rb")].each {|f| require f}
require 'croupier/cli/application'
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
  end
end
