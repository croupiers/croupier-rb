module Croupier
  module Distributions

    #####################################################################
    # Cauchy Distribution
    # Continuous probability distribution describing resonance behavior.
    #
    class Cauchy < ::Croupier::Distribution

      distribution_name "Cauchy distribution"

      distribution_description "Continuous probability distribution describing resonance behavior"

      cli_name "cauchy"

      cli_options({
        options: [
          [:location, 'location param', {type: :float, default:0.0}],
          [:scale, 'scale param', {type: :float, default: 1.0}],
        ],
        banner: "Cauchy continuous distribution. Generate numbers following a Cauchy distribution with location and scale parameters"
      })

      inv_cdf do |n|
        location + (scale * Math.tan( Math::PI * (0.5 - n)))
      end

      def initialize(options={})
        super(options)
        raise Croupier::InputParamsError, "Invalid scale value, it must be positive" unless params[:scale] > 0
      end

      def location
        params[:location]
      end

      def scale
        params[:scale]
      end
    end
  end
end
