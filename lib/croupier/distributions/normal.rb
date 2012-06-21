module Croupier
  module Distributions

    #####################################################################
    # Normal Distribution
    # Continuous distribution (mu,sigma) (defaults to (0,1) ) where
    # mu is the mean and sigma the standard deviation.
    #
    class Normal < ::Croupier::Distribution

      def initialize(options={})
        @name = "Normal distribution"
        @description = "Continuous distribution (mu,sigma) (defaults to (0,1) ) where mu is the mean and sigma the standard deviation."
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
        gen.map!{ |x| x * @parameters[:std] }  if @parameters[:std] != 1
        gen.map!{ |x| x + @parameters[:mean] } if @parameters[:mean] != 0

        # Adjust length
        n.odd? ? gen[0..-2] : gen
      end

      def default_parameters
        {:mean => 0, :std => 1}
      end

      def self.cli_name
        "normal"
      end

      def self.cli_options
        {:options => [
           [:mean, 'mean of the distribution', {:type=>:float, :default => 0.0}],
           [:std, 'standard deviation of the distribution', {:type=>:float, :default => 1.0}]
         ],
         :banner => "Normal distribution. Generate numbers following a continuous distribution in the real line with mean :mean and standard deviation :std."
        }
      end
    end
  end
end
