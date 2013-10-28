module Croupier
  module Distributions

    #####################################################################
    # Binomial Distribution
    # Discrete probability distribution of the number of successes in a
    # sequence of Bernoulli trials each of which yields success with
    # probability p
    class Binomial < ::Croupier::Distribution

      distribution_name "Binomial distribution"

      distribution_description "Discrete probability distribution of the number of successes in a sequence of Bernoulli trials."

      cli_name "binomial"

      cli_option :size, 'number of trials', {type: :integer, default: 1}
      cli_option :success, 'success probability of each trial', {type: :float, short: "-p", default: 0.5}

      cli_banner "Binomial distribution. Discrete probability distribution of the number of successes in a sequence of Bernoulli trials."


      enumerator_block do |y|
        g = ::Croupier::Distributions.geometric(success: success).to_enum.lazy
        loop do
          x = -1; s = 0

          begin
            s += g.next
            x += 1
          end while s <= size

          y << x
        end
      end

      def initialize(options={})
        super(options)
        raise Croupier::InputParamsError, "Probability of success must be in the interval [0,1]" if params[:success] > 1 || params[:success] < 0
      end
    end
  end
end
