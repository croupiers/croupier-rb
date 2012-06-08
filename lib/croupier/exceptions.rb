module Croupier
  # Croupier custom Error class.
  class Error < StandardError; end
  # Error when a non existent or invalid option is used.
  class InvalidOptionError < Error; end
  # Error in some of the input params.
  class InputParamsError < Error; end
end
