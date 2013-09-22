module Croupier
  module Distributions

    #####################################################################
    # Uniform Distribution
    # Continuous distribution where all points in an interval have
    # the same probability.
    #
    class Uniform < ::Croupier::Distribution

      distribution_name "Uniform distribution"

      distribution_description "Continuous distribution on [a,b] (defaults to [0,1]) where all points in the interval are equally likely"

      cli_name "uniform"

      cli_options({
        options: [
          [:included, 'interval included value', {type: :float, short: "-i", default: 0.0}],
          [:excluded, 'interval excluded value', {type: :float, short: "-e", default: 1.0}]
        ],
        banner: "Uniform distribution. Generate numbers following a continuous distribution on [a,b] (given a=min(included, excluded) and b=max(included,excluded))  where all points in the interval are equally likely."
      })

      def initialize(options={})
        super options
        @exclude_value = if self.inverted?
                           ->(n) { 1-n }
                         else
                           ->(n) { n }
                         end
        @min, @max = if self.inverted?
                       [params[:excluded], params[:included]]
                     else
                       [params[:included], params[:excluded]]
                     end
        @range = @max - @min
      end

      attr_reader :exclude_value, :min, :max, :range

      def inverted?
        params[:included] > params[:excluded]
      end

      def to_enum
        @enum ||= base_enum.lazy.
            map(&exclude_value).
            map do |n|
              min + range * n
            end
      end

      protected
      def base_enum
        Enumerator.new do |y|
          loop do
            y << Croupier.rand
          end
        end
      end
    end
  end
end
