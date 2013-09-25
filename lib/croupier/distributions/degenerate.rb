module Croupier
  module Distributions

    #####################################################################
    # Degenerate Distribution
    # Discrete probability distribution that returns the same value.
    class Degenerate < ::Croupier::Distribution

      distribution_name "Degenerate distribution"

      distribution_description "Discrete probability distribution that returns the same value each time."

      cli_name "degenerate"

      cli_option :constant, 'value to be returned', {type: :float, default: 42.0}

      cli_banner "Degenerate distribution. Discrete probability distribution that returns the same value each time."

      enumerator_block do |y|
        loop do
          y << params[:constant]
        end
      end

      def initialize(options={})
        super(options)
      end
    end
  end
end
