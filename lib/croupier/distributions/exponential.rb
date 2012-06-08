module Croupier
  module Distributions
    
    #####################################################################
    # Uniform Distribution 
    # Continous distribution where all points in an interval have 
    # the same probability.
    #
    class Exponential < ::Croupier::Distribution
      
      def initialize(options={})
        @name = "Exponential distribution"
        @description = "Continuous probability distribution with a lambda param rate describing the time between events in a Poisson process"
        configure(options)
      end

      def generate_number
        raise Croupier::InputParamsError, "Invalid interval values" if @parameters[:lambda] <= 0
        (-1/@parameters[:lambda]) * Math.log(rand)
      end

      def default_parameters
        {:lambda => 1.0}
      end

      def self.cli_name
        "exponential"
      end

      def self.cli_options
        {:options => [
           [:lambda, 'rate param', {:type=>:float, :default => 1.0}]
         ],
         :banner => "Exponential distribution. Generate numbers following a exponential distribution for a given lambda rate"
        }
      end
    end
  end
end
