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

      cli_options({
        options: [
          [:a, 'lower limit', {type: :float, default: 0.0}],
          [:b, 'upper limit', {type: :float, default: 1.0}],
          [:c, 'mode', {type: :float, default: 0.5}]
        ],
        banner: "Triangular distribution. Continuous distribution whose support is the interval (a,b), with mode c."
      })

      def initialize(options={})
        configure(options)
        raise Croupier::InputParamsError, "Invalid interval values" if params[:a] >= params[:b]
        if params[:c] < params[:a] || params[:b] <  params[:c]
          warn("Mode is not in the support. Mode value will be change to median.")
          params[:c] = (params[:a]+params[:b])/2;
        end
        @F_c = (params[:c]-params[:a])/(params[:b]-params[:a])
      end

      def inv_cdf n
        if n < @F_c
          params[:a] + Math.sqrt(   n   * (params[:b] - params[:a]) * (params[:c] - params[:a]) )
        else
          params[:b] - Math.sqrt( (1-n) * (params[:b] - params[:a]) * (params[:b] - params[:c]) )
        end
      end
    end
  end
end
