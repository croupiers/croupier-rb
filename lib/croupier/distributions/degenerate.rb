module Croupier
  module Distributions

    #####################################################################
    # Degenerate Distribution
    # Discrete probability distribution that returns the same value.
    class Degenerate < ::Croupier::Distribution

      distribution_name "Degenerate distribution"

      distribution_description "Discrete probability distribution that returns the same value each time."

      cli_name "degenerate"

      cli_options({
        options: [
          [:constant, 'value to be returned', {type: :float, default: 42.0}]
        ],
        banner: "Degenerate distribution. Discrete probability distribution that returns the same value each time."
       })

      def initialize(options={})
        super(options)
      end

      def generate_number
        params[:constant]
      end
    end
  end
end
