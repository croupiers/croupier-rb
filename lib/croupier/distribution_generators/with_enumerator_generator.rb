module Croupier

  module DistributionGenerators

    class WithEnumeratorGenerator < ::Croupier::DistributionGenerator

      method_name "with_enumerator"

      def initilize distribution, &block
        super distribution, &block
      end

      def to_enum
        Enumerator.new do |y|
          self.distribution.instance_exec(y,&self.block)
        end
      end
    end
  end
end