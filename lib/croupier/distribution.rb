module Croupier

  #####################################################################
  # Distribution represents the probability distribution used to
  # generate the sample of random numbers.
  #
  class Distribution
    attr_accessor :parameters
    attr_reader :name, :description

    # Initializes Distribution object and adds received options to the distribution parameters.
    def initialize(options={})
      @name = nil
      @description = nil
      configure(options)
    end

    # Merge the hash of options into the default distribution parameters
    def configure(options={})
      @parameters = default_parameters.merge options
    end

    # Default hash of distribution parameters
    def default_parameters
      {}
    end

    # Main method to generate n random numbers using the current probability distribution
    def generate_sample(n=1)
      if self.respond_to? :inv_cdf
        (1..n).map{ inv_cdf(rand) }
      else
        (1..n).map { generate_number }
      end
    end

    # Generates one random number using the current probability distribution
    def generate_number
      if self.respond_to? :inv_cdf
        inv_cdf(rand)
      else
        generate_sample 1
      end
    end

    # Sick of using @parameters. Too long for me. # Sergio
    def params
      @parameters
    end

    # Defines a hash with banner and all available CLI options.
    # It is a hash with two keys:
    #  :banner =>  A string used as banner in the command line help
    #  :options => An array of arrays each one representing a CLI option
    #             with the following format:[:option, 'description', {hash of option params}]
    #   Example:
    #   {:banner => "This distribution generates only number 33",
    #    :options => [
    #      [:mean, 'The mean of the distribution', {:default => 33}],
    #      [:median, 'Median of the distribution',{:default => 33.0, :type => :float}]
    #    ]
    #   }
    def self.cli_options
      {:banner => nil, :options=>[]}
    end

    # Defines the name of this Distribution to be used from the CLI.
    def self.cli_name
      ''
    end
  end

  module Distributions
  end
end
