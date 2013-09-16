module Croupier
  module Distributions

    #####################################################################
    # Exponential Distribution
    # Continuous probability distribution with a lambda param rate
    # describing the time between events in a Poisson process
    #
    class Exponential < ::Croupier::Distribution

      distribution_name "Exponential distribution"

      distribution_description "Continuous probability distribution with a lambda param rate describing the time between events in a Poisson process"

      cli_name "exponential"

      cli_options({
        options: [
          [:lambda, 'rate param', {type: :float, default: 1.0}]
        ],
        banner: "Exponential distribution. Generate numbers following a exponential distribution for a given lambda rate"
      })

      def initialize(options={})
        super(options)
        raise Croupier::InputParamsError, "Invalid interval values" if params[:lambda] <= 0
      end

      def inv_cdf n
        (-1/params[:lambda]) * Math.log(n)
      end
    end
  end
end
