module Croupier
  module Distributions

    #####################################################################
    # Uniform Distribution
    # Continuous distribution where all points in an interval have
    # the same probability.
    #
    class Uniform < ::Croupier::Distribution

      distribution_name "Uniform distribution"

      distribution_description "Continuous distribution on [a,b] (defaults to [0,1]) where all points in the interval are equally likely"

      cli_name "uniform"

      cli_options({
        options: [
          [:a, 'interval start value', {type: :float, default: 0.0}],
          [:b, 'interval end value', {type: :float, default: 1.0}]
        ],
        banner: "Uniform distribution. Generate numbers following a continuous distribution on [a,b] (defaults to [0,1]) where all points in the interval are equally likely"
      })

      def initialize(options={})
        super options
        raise Croupier::InputParamsError, "Invalid interval values" if params[:b] < params[:a]
      end

      def generate_number
        rand Range.new(params[:a], params[:b])
      end
    end
  end
end
