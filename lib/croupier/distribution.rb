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
      # @param options [Hash] new cli options
      # return [Hash] current cli options
      def cli_options options=nil
        @cli_options = options if options
        @cli_options ||= {}
      end

      # Adds an option to the :options Array in cli_options hash.
      #
      # @param option [Symbol] new cli option
      # @param description [String] description of the cli option
      # @param params [Hash] option params for the cli option
      # return [Array] current cli options
      def cli_option option, description, params
        cli_options[:options] ||= []
        cli_options[:options] << [option, description, params]
      end

      # Sets the value for the :banner key in cli_options hash.
      #
      # @param banner [String] new cli banner
      # return [String] current cli banner
      def cli_banner banner
        cli_options[:banner] = banner
      end

      # Sets the cli_name if given.
      #
      # @param cli_name [String] new cli name
      # @return [String] current cli name
      def cli_name cli_name=nil
        @cli_name = cli_name if cli_name
        @cli_name
      end

      def default_parameters
        Hash[(cli_options[:options]||{}).map do |name, desc, hash|
          [name,hash[:default]]
        end]
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
      self.class.default_parameters
    end

    # Main method to generate n random numbers using the current probability distribution
    def generate_sample(n=1)
      self.to_enum.take(n).to_a
    end

    # Generates one random number using the current probability distribution
    def generate_number
      self.to_enum.next
    end

    # convenience method for lazy programmers
    def params
      @parameters
    end

    # Make Croupier::Distribution an Enumerable
    # Read the tests for the instance methods.
    # Then, cry.
    Enumerable.instance_methods.each do |method|
      self.send(:define_method, method) do |*args, &block|
        self.to_enum.send(method, *args, &block)
      end
    end

    def each &block
      if block_given?
        to_enum.each &block
      else
        to_enum.each
      end
    end

    def to_enum
      @enum ||= @generator.to_enum.lazy
    end

    protected
    def create_generator
      if self.class.generator_class && self.class.generator_block
        @generator = self.class.generator_class.new self, &self.class.generator_block
      end
    end
  end

end
