module Croupier
  module Distributions

    #####################################################################
    # Cauchy Distribution
    # Continuous probability distribution describing resonance behavior.
    #
    class Cauchy < ::Croupier::Distribution

      distribution_name "Cauchy distribution"

      distribution_description "Continuous probability distribution describing resonance behavior"

      def initialize(options={})
        configure(options)
        raise Croupier::InputParamsError, "Invalid scale value, it must be positive" unless params[:scale] > 0
      end

      def inv_cdf n
        params[:location] + (params[:scale] * Math.tan(Math::PI * (0.5 - n)))
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
