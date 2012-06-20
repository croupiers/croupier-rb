module Croupier
  module Distributions

    #####################################################################
    # Triangular Distribution
    # Continuous probability distribution whose lower limit
    # is a, upper limit b and mode c (a <= c <= b).
    class Triangular < ::Croupier::Distribution

      def initialize(options={})
        @name = "Triangular distribution"
        @description = "Continuous probability distribution whose lower limit is a, upper limit b and mode c (a <= c <= b)"
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

      def default_parameters
        {:a => 0.0, :b => 1.0, :c => 0.5}
      end

      def self.cli_name
        "triangular"
      end

      def self.cli_options
        {:options => [
           [:a, 'lower limit', {:type=>:float, :default => 0.0}],
           [:b, 'upper limit', {:type=>:float, :default => 1.0}],
           [:c, 'mode'       , {:type=>:float, :default => 0.5}]
         ],
         :banner => "Triangular distribution. Continuous distribution whose support is the interval (a,b), with mode c."
        }
      end
    end
  end
end
