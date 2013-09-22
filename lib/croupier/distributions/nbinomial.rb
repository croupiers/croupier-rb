module Croupier
  module Distributions

    #####################################################################
    # Negative Binomial Distribution
    # Discrete probability distribution of the number of successes in a
    # sequence of Bernoulli trials before a specified (non-random)
    # number of failures (denoted size) occur.
    #
    # Wikipedia -- http://en.wikipedia.org/wiki/Negative_binomial_distribution
    class Nbinomial < ::Croupier::Distribution

      distribution_name "Negative binomial distribution"

      distribution_description "Discrete probability distribution of the number of successes in a sequence of Bernoulli trials before a specified (non-random) number of failures (denoted size) occur."

      cli_name "nbinomial"

      cli_options({
        options: [
          [:size, 'number of errors', {type: :integer, default: 1}],
          [:success, 'success probability of each trial', {type: :float, short: "-p", default: 0.5}]
        ],
        banner: "Negative binomial distribution. Discrete probability distribution of the number of successes in a sequence of Bernoulli trials before a specified (non-random) number of failures (denoted size) occur."
      })

      enumerator do |c|
        c.geometric(sucess: success).to_enum.each_slice(size).map do |sample|
          sample.inject(-size, &:+)
        end
      end

      def initialize(options={})
        super(options)
        raise Croupier::InputParamsError, "Probability of success must be in the interval [0,1]" if params[:success] > 1 || params[:success] < 0
      end

      def success
        params[:succes]
      end

      def size
        params[:size]
      end
    end
  end
end
