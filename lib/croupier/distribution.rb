module Croupier

  #####################################################################
  # Distribution represents the probability distribution used to
  # generate the sample of random numbers.
  #
  class Distribution
    attr_accessor :parameters
    attr_accessor :generator

    class << self
      # Sets the name property of the distribution.
      # if given
      #
      # @param distribution_name [String,nil] the name of the distribution
      # @return [String] current distribution name
      def distribution_name distribution_name=nil
        @distribution_name = distribution_name if distribution_name
        @distribution_name
      end

      # Sets the description property of the distribution
      # if given
      #
      # @param description [String,nil] description for the distribution
      # @return [String] current description
      def distribution_description description=nil
        @distribution_description = description if description
        @distribution_description
      end

      # Sets the generator class for this distribution, if given
      #
      # @param generator_class [Class] class for the generator for this distribution
      # @return [Class] current generator class
      def generator_class generator_class=nil
        @generator_class = generator_class if generator_class
        @generator_class
      end

      # Sets the generator block for this distribution, if given
      #
      # @param block [Proc] block for the generator
      # @return [Proc] current generator block
      def generator_block &block
        @generator_block = block if block_given?
        @generator_block
      end

      def method_missing(method, *args, &block) # :nodoc:
        return super unless self.respond_to?(method)
        generator = ::Croupier::DistributionGenerators.all.find{|d| d.method_name == method.to_s}
        self.generator_class generator
        self.generator_block &block
      end

      def respond_to?(method, include_private = false) # :nodoc:
        ::Croupier::DistributionGenerators.list.include?(method.to_s) || super(method, include_private)
      end
    end

    # Initializes Distribution object and adds received options to the distribution parameters.
    def initialize(options={})
      configure(options)
      create_generator
    end

    # Alias for `self.class.distribution_name`
    # @return [String] distribution name
    def name
      self.class.distribution_name
    end

    def description
      self.class.distribution_description
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
        (1..n).map{ generate_number }
      end
    end

    # Generates one random number using the current probability distribution
    def generate_number
      if self.respond_to? :inv_cdf
        inv_cdf(rand)
      else
        generate_sample(1).first
      end
    end

    # convenience method for lazy programmers
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

    def to_enum
      Enumerator.new do |y|
        loop do
          y << generate_number
        end
      end
    end

    protected
    def create_generator
      if self.class.generator_class && self.class.generator_block
        @generator = self.class.generator_class.new self, &self.class.generator_block
      end
    end
  end

end
