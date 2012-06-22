module Croupier
  module Distributions

    #####################################################################
    # Negative Binomial Distribution
    # Discrete probability distribution of the number of successes in a
    # sequence of Bernoulli trials before a specified (non-random)
    # number of failures (denoted size) occur.
    #
    # The parameter prob expresses the probability of success.
    # Wikipedia -- http://en.wikipedia.org/wiki/Negative_binomial_distribution
    class Nbinomial < ::Croupier::Distribution

      def initialize(options={})
        @name = "Negative binomial distribution"
        @description = "Discrete probability distribution of the number of successes in a sequence of Bernoulli trials before a specified (non-random) number of failures (denoted size) occur."
        configure(options)
        raise Croupier::InputParamsError, "Param prob must be in the interval [0,1]" if params[:prob] > 1 || params[:prob] < 0
      end

      # Fair point: it is not the inverse of the cdf,
      # but it generates the distribution from an uniform.
      def generate_sample n=1
        generate_geometrics(n).each_slice(params[:size]).map do |sample|
          sample.inject(-params[:size], &:+) # Inject starts on -size because
          # this way it is equivalent to:
          # sample.map{|x| x - 1}.inject(&:+)
        end
      end

      def base_geometric
        ::Croupier::Distributions::Geometric.new(p: params[:prob])
      end

      def generate_geometrics(n)
        base_geometric.generate_sample(params[:size]*n)
      end

      def default_parameters
        {:prob => 0.5, :size => 1}
      end

      def self.cli_name
        "nbinomial"
      end

      def self.cli_options
        {:options => [
           [:size, 'number of errors', {:type => :integer, :default => 1}],
           [:prob, 'success probability of each trial', {:type=>:float, :default => 0.5}]
         ],
         :banner => "Negative binomial distribution. Discrete probability distribution of the number of successes in a sequence of Bernoulli trials before a specified (non-random) number of failures (denoted size) occur."
        }
      end
    end
  end
end
