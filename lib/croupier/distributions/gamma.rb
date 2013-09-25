module Croupier
  module Distributions

    #####################################################################
    # Gamma Distribution
    # Family of continuous distributions with two parameters shape
    # (defaults to 1) and scale (defaults to 1).
    class Gamma < ::Croupier::Distribution

      distribution_name "Gamma distribution"

      distribution_description "Family of continuous distributions with two parameters, shape and scale"

      cli_name "gamma"

      cli_option :shape, 'shape of the distribution', {type: :float, default: 1.0}
      cli_option :scale, 'scale of the distribution', {type: :float, default: 1.0}

      cli_banner "Family of continuous distributions with two parameters, shape and scale."

      enumerator do |c|
        c.degenerate(constant: scale).zip(xi_enum, adjust_enum).map do |s,x,a|
          s * (x - a)
        end
      end

      def initialize(options={})
        super(options)
      end

      def shape
        params[:shape]
      end

      def scale
        params[:scale]
      end

      def delta
        @delta ||= shape - shape.floor
      end

      def v_0
        @v_0 ||= Math::E / (delta + Math::E)
      end

      protected

      def adjust_enum
        uniform.map{|n| Math.log(n) }.each_slice(shape.floor).map do |slice|
          slice.inject &:+
        end
      end

      # Based on Ahrens-Dieter acceptance-rejection method
      # as described on Wikipedia:
      # http://en.wikipedia.org/wiki/Gamma_distribution#Generating_gamma-distributed_random_variables

      def xi_enum
        uniform.zip(uniform, uniform).map do |v1, v2, v3|
          x = xi v1, v2, v3
          [x, eta(x, v1, v2, v3)]
        end.reject do |x,e|
          e > (x** (delta - 1)) * (Math.exp(-x))
        end.map do |x,e|
          x
        end
      end

      def xi v1, v2, v3
        if v1 < v_0
          v2** (1/delta)
        else
          1 - Math.log(v2)
        end
      end

      def eta xi, v1, v2, v3
        if v1 < v_0
          v3 * (xi** (delta - 1))
        else
          v3 * Math.exp(-xi)
        end
      end

      def uniform
        ::Croupier::Distributions.uniform(included: 1, excluded: 0).to_enum.lazy
      end
    end
  end
end
