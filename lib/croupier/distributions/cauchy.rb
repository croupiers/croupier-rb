module Croupier
  module Distributions

    #####################################################################
    # Cauchy Distribution
    # Continuous probability distribution describing resonance behavior.
    #
    class Cauchy < ::Croupier::Distribution

      def initialize(options={})
        @name = "Cauchy distribution"
        @description = "Continuous probability distribution describing resonance behavior"
        configure(options)
        raise Croupier::InputParamsError, "Invalid scale value, it must be positive" unless params[:scale] > 0
      end

      def generate_number
        n = rand
        n == 0 ? generate_number : params[:location] + (params[:scale] * Math.tan(Math::PI * (n - 0.5)))
      end

      def default_parameters
        {:location => 0.0, :scale => 1.0}
      end

      def self.cli_name
        "cauchy"
      end

      def self.cli_options
        {:options => [
           [:location, 'location param', {:type=>:float, :default => 0.0}],
           [:scale, 'scale param', {:type=>:float, :default => 1.0}],
         ],
         :banner => "Cauchy continuous distribution. Generate numbers following a Cauchy distribution with location and scale parameters"
        }
      end
    end
  end
end