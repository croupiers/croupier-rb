module Croupier
  module Distributions

    #####################################################################
    # Triangular Distribution
    # Continuous probability distribution whose lower limit
    # is a, upper limit b and mode c (a <= c <= b).
    class Triangular < ::Croupier::Distribution

      distribution_name "Triangular distribution"

      distribution_description "Continuous probability distribution whose lower limit is a, upper limit b and mode c (a <= c <= b)"

      cli_name "triangular"

      cli_option :lower, 'lower limit', {type: :float, short: '-a', default: 0.0}
      cli_option :upper, 'upper limit', {type: :float, short: '-b', default: 1.0}
      cli_option :mode, 'mode', {type: :float, short: '-c', default: 0.5}

      cli_banner "Triangular distribution. Continuous distribution whose support is the interval (a,b), with mode c."

      inv_cdf do |n|
        if n < @F_c
          lower + Math.sqrt(   n   * range * (mode - lower) )
        else
          upper - Math.sqrt( (1-n) * range * (upper - mode) )
        end
      end

      def initialize(options={})
        super(options)
        if params[:lower] >= params[:upper]
          ::Croupier.warn("Lower limit is greater than upper limit. Changing their values.")
          params[:lower], params[:upper] = params[:upper], params[:lower]
        end
        if params[:mode] < params[:lower] || params[:upper] <  params[:mode]
          ::Croupier.warn("Mode is not in the support. Mode value will be change to median.")
          params[:mode] = (params[:lower]+params[:upper])/2.0;
        end
        @F_c = (params[:mode]-params[:lower]).to_f/(params[:upper]-params[:lower])
      end

      def range
        @range ||= upper - lower
      end
    end
  end
end
