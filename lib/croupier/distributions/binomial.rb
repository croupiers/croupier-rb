module Croupier
  module Distributions

    #####################################################################
    # Binomial Distribution
    # Discrete probability distribution of the number of successes in a
    # sequence of Bernoulli trials each of which yields success with
    # probability p
    class Binomial < ::Croupier::Distribution

      distribution_name "Binomial distribution"

      def initialize(options={})
        @description = "Discrete probability distribution of the number of successes in a sequence of Bernoulli trials."
        configure(options)
        raise Croupier::InputParamsError, "Probability of success must be in the interval [0,1]" if params[:success] > 1 || params[:success] < 0
      end

      def generate_number
        x = -1
        s = 0
        loop do
          s += base_geometric.generate_number
          x += 1
          break if s > params[:size]
        end
        x
      end

      def default_parameters
        {:success => 0.5, :size => 1}
      end

      def self.cli_name
        "binomial"
      end

      def self.cli_options
        {:options => [
           [:size, 'number of trials', {:type => :integer, :default => 1}],
           [:success, 'success probability of each trial', {:type=>:float, :short => "-p", :default => 0.5}]
         ],
         :banner => "Binomial distribution. Discrete probability distribution of the number of successes in a sequence of Bernoulli trials."
        }
      end

      private
      def base_geometric
        @base_geometric ||= ::Croupier::Distributions::Geometric.new(success: params[:success])
      end

    end
  end
end
