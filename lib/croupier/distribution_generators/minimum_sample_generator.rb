module Croupier

  module DistributionGenerators

    class MinimumSampleGenerator < ::Croupier::DistributionGenerator

      method_name "minimum_sample"

      def initilize distribution, &block
        super distribution, &block
      end

      def to_enum
        Enumerator.new do |y|
          loop do
            distribution.instance_exec(&self.block).each do |a|
              y << a
            end
          end
        end.lazy
      end
    end
  end
end