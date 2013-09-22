module Croupier
  module Distributions

    #####################################################################
    # Poisson Distribution
    # Discrete probability distribution that expresses the probability
    # of a given number of event occurring in a fixed interval of time
    # and/or space if these events occur with a known average rate
    # and independently of the time since the las event.
    #
    # Wikipedia http://en.wikipedia.org/wiki/Poisson_distribution
    class Poisson < ::Croupier::Distribution

      distribution_name "Poisson distribution"

      distribution_description "Discrete probability distribution that expresses the probability of a given number of events occurring in a fixed interval of time."

      cli_name "poisson"

      cli_options({
        options: [
          [:lambda, 'rate parameter (equal to the mean of the distribution)', {type: :integer, default: 50}]
        ],
        banner: "Poisson distribution. Discrete probability distribution that expresses the probability of a given number of events occurring in a fixed interval of time."
      })

      with_enumerator do |y|
        l = Math.exp(-lambda)
        loop do
          k = 0, p = 1;
          while p > l
            p *= ::Croupier.rand
            k += 1
          end
          y << (k-1)
        end
      end

      def initialize(options={})
        super(options)
      end

      def lambda
        params[:lambda]
      end
    end
  end
end
