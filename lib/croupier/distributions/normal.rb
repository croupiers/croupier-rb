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

      cli_options({
        options: [
          [:mean, 'mean of the distribution', {type: :float, default: 0.0}],
          [:std, 'standard deviation of the distribution', {type: :float, default: 1.0}]
        ],
        banner: "Normal distribution. Generate numbers following a continuous distribution in the real line with mean :mean and standard deviation :std."
      })

      def initialize(options={})
        configure(options)
      end

      def generate_sample(n=1)
        sample = n.odd? ? n+1 : n

        # Generate
        gen = (1..sample).map do |x|
          1 - rand # because uniform need to be in (0,1]
        end.each_slice(2).flat_map do |x, y|
          [
            Math.sqrt(-2*Math.log(x)) * Math.cos(2*Math::PI*y),
            Math.sqrt(-2*Math.log(x)) * Math.sin(2*Math::PI*y)
          ]
        end

        # Adjust parameters.
        gen.map!{ |x| x * params[:std] }  if params[:std] != 1
        gen.map!{ |x| x + params[:mean] } if params[:mean] != 0

        # Adjust length
        n.odd? ? gen[0..-2] : gen
      end
    end
  end
end
