module Croupier
  module Distributions

    #####################################################################
    # Poisson Distribution
    # Discrete probability distribution that expresses the probability
    # of a given number of event occurrin in a fixed interval of time
    # and/or space if these events occur with a known average rate
    # and independently of the time since the las event.
    #
    # Wikipedia http://en.wikipedia.org/wiki/Poisson_distribution
    class Poisson < ::Croupier::Distribution

      def initialize(options={})
        @name = "Poisson distribution"
        @description = "Discrete probability distribution that expresses the probability of a given number of events occurring in a fixed interval of time."
        configure(options)
      end

      def generate_number
        l = Math.exp(-params[:lambda])
        k = 0; p = 1;
        while p > l
          p *= rand
          k += 1;
        end
        k-1
      end

      def default_parameters
        {:lambda => 50}
      end

      def self.cli_name
        "poisson"
      end

      def self.cli_options
        {:options => [
           [:lambda, 'rate parameter (equal to the mean of the distribution)', {:type=>:integer, :default => 50}]
         ],
         :banner => "Poisson distribution. Discrete probability distribution that expresses the probability of a given number of events occurring in a fixed interval of time."
        }
      end
    end
  end
end
