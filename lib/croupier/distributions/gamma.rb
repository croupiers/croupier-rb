module Croupier
  module Distributions

    #####################################################################
    # Gamma Distribution
    # Family of continuous distributions with two parameters shape
    # (defaults to 1) and scale (defaults to 1).
    class Gamma < ::Croupier::Distribution

      def initialize(options={})
        @name = "Gamma distribution"
        @description = "Family of continuous distributions with two parameters, shape and scale"
        configure(options)
      end

      def generate_number
        params[:scale] * (gen_xi - (1..params[:shape].floor).map { Math.log(1 - rand) }.inject(&:+) )
      end

      def default_parameters
        {:shape => 1.0, :std => 1.0}
      end

      def self.cli_name
        "gamma"
      end

      def self.cli_options
        {:options => [
           [:shape, 'shape of the distribution', {:type=>:float, :default => 1.0}],
           [:scale, 'scale of the distribution', {:type=>:float, :default => 1.0}]
         ],
         :banner => "Family of continuous distributions with two parameters, shape and scale."
        }
      end

      protected
      # Based on Ahrens-Dieter acceptance-rejection method
      # as described on Wikipedia:
      # http://en.wikipedia.org/wiki/Gamma_distribution#Generating_gamma-distributed_random_variables
      def gen_xi
        delta = params[:shape] - params[:shape].floor
        v_0 = Math::E / ( delta  + Math::E )
        eta = 1; xi = 0;

        while eta > (xi ** (delta - 1)) * (Math::E ** -xi)
          # Generate thre independent uniformly distributed
          # on interval (0,1]random variables
          v1 = 1 - rand; v2 = 1 - rand; v3 = 1 - rand;

          # Generate a new xi.
          if v_1 < v_0
            xi = (v_2 ** (1/delta))
            eta = v_3 * (xi ** (delta - 1))
          else
            xi = 1 - Math.log(v_2)
            eta = v_3 * (Math::E ** (-xi))
          end
        end

        xi
      end
    end
  end
end
