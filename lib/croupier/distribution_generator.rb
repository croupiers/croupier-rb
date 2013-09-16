module Croupier

  class DistributionGenerator

    class << self

      # Gets and optionally sets the method name for this generator
      #
      # @param new_method_name [String] new method name
      # @return [String] current method name
      def method_name new_method_name=nil
        @method_name = new_method_name if new_method_name
        @method_name
      end
    end

    attr_reader :distribution
    attr_reader :block

    def initialize distribution, &block
      @distribution = distribution
      @block = block
    end


    # Accessor to distribution parameters
    #
    # @return [Hash<String,Object>] distribution parameters
    def params
      self.distribution.params
    end

    def croupier
      ::Croupier::Distributions
    end

    # @abstract Given some parameters, returns the minimum sample
    # it can generate. Some generators generate more
    # than one number each iteration.
    #
    # @return [Array<Numeric>] sample
    def generate_minimum_sample

    end

    def to_enum
      Enumerator.new do |y|
        loop do
          sample = self.generate_minimum_sample
          sample.each do |s|
            y << s
          end
        end
      end
    end
  end
end