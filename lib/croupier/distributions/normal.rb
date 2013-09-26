module Croupier
  module Distributions

    #####################################################################
    # Normal Distribution
    # Continuous distribution (mu,sigma) (defaults to (0,1) ) where
    # mu is the mean and sigma the standard deviation.
    #
    class Normal < ::Croupier::Distribution

      distribution_name "Normal distribution"

      distribution_description "Continuous distribution (mu,sigma) (defaults to (0,1) ) where mu is the mean and sigma the standard deviation."

      cli_name "normal"

      cli_option :mean, 'mean of the distribution', {type: :float, default: 0.0}
      cli_option :std, 'standard deviation of the distribution', {type: :float, default: 1.0}

      cli_banner "Normal distribution. Generate numbers following a continuous distribution in the real line with mean :mean and standard deviation :std."

      minimum_sample do
        x, y = 1 - ::Croupier.rand, 1 - ::Croupier.rand
        [
          Math.sqrt(-2*Math.log(x)) * Math.cos(2*Math::PI*y),
          Math.sqrt(-2*Math.log(x)) * Math.sin(2*Math::PI*y)
        ]
      end

      def initialize(options={})
        super(options)
      end

      # FIXME: Create some sort of adjustment for these kinds of things.
      def to_enum
        @generator.to_enum.
          map {|x| x * std}.  # Adjust standard deviation
          map {|x| x + mean}  # Adjust mean
      end
    end
  end
end
