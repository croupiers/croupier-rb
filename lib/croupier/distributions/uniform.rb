module Croupier
  module Distributions

    #####################################################################
    # Uniform Distribution
    # Continous distribution where all points in an interval have
    # the same probability.
    #
    class Uniform < ::Croupier::Distribution

      def initialize(options={})
        @name = "Uniform distribution"
        @description = "Continuous distribution on [a,b] (defaults to [0,1]) where all points in the interval are equally likely"
        configure(options)
      end

      def generate_single_number
        raise Croupier::InputParamsError, "Invalid interval values" if @parameters[:b] < @parameters[:a]
        rand Range.new(@parameters[:a], @parameters[:b])
      end

      def default_parameters
        {:a => 0, :b => 1}
      end

      def self.cli_name
        "uniform"
      end

      def self.cli_options
        {:options => [
           [:a, 'interval start value', {:type=>:float, :default => 0.0}],
           [:b, 'interval end value', {:type=>:float, :default => 1.0}]
         ],
         :banner => "Uniform distribution. Generate numbers following a continuous distribution on [a,b] (defaults to [0,1]) where all points in the interval are equally likely"
        }
      end
    end
  end
end
