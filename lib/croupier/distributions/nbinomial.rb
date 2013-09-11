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

      def initialize(options={})
        configure(options)
        raise Croupier::InputParamsError, "Probability of success must be in the interval [0,1]" if params[:success] > 1 || params[:success] < 0
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

      def default_parameters
        {:success => 0.5, :size => 1}
      end

      def self.cli_name
        "nbinomial"
      end

      def self.cli_options
        {:options => [
           [:size, 'number of errors', {:type => :integer, :default => 1}],
           [:success, 'success probability of each trial', {:type=>:float, :short => "-p", :default => 0.5}]
         ],
         :banner => "Negative binomial distribution. Discrete probability distribution of the number of successes in a sequence of Bernoulli trials before a specified (non-random) number of failures (denoted size) occur."
        }
      end

      private
      def base_geometric
        ::Croupier::Distributions::Geometric.new(success: params[:success])
      end

      def generate_geometrics(n)
        base_geometric.generate_sample(params[:size]*n)
      end

    end
  end
end
