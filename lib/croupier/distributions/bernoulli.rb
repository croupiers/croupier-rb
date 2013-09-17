module Croupier
  module Distributions

    #####################################################################
    # Bernoulli Distribution
    # Discrete probability distribution taking value 1 with success
    # probability p and value 0 with failure probability 1-p
    # Equivalent to a Binomial(1,p)
    class Bernoulli < ::Croupier::Distribution

      distribution_name "Bernoulli distribution"
      distribution_description "Discrete probability distribution taking value 1 with success probability p and value 0 with failure probability 1-p."

      cli_name "bernoulli"

      cli_options({
        options: [
          [:success, 'success probability', {type: :float, short: "-p", default: 0.5}]
        ],
        banner: "Bernoulli distribution. Discrete probability distribution taking value 1 with success probability p and value 0 with failure probability 1-p."
      })

      def initialize(options={})
        super(options)
        raise Croupier::InputParamsError, "Probability of success must be in the interval [0,1]" if params[:success] > 1 || params[:success] < 0
      end

      def generate_number
        binomial_1_p.generate_number
      end

      private
      def binomial_1_p
        @binomial_1_p ||= ::Croupier::Distributions::Binomial.new(:success => params[:success], :size => 1)
      end
    end
  end
end
