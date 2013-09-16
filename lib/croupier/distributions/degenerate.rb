module Croupier
  module Distributions

    #####################################################################
    # Degenerate Distribution
    # Discrete probability distribution that returns the same value.
    class Degenerate < ::Croupier::Distribution

      distribution_name "Degenerate distribution"

      distribution_description "Discrete probability distribution that returns the same value each time."

      cli_options({
        options: [
          [:constant, 'value to be returned', {type: :float, default: 42.0}]
        ],
        banner: "Degenerate distribution. Discrete probability distribution that returns the same value each time."
       })

      def initialize(options={})
        configure(options)
      end

      def generate_number
        params[:constant]
      end

      def self.cli_name
        "degenerate"
      end
    end
  end
end
