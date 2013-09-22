module Croupier

  module DistributionGenerators

    # Call `with_enumerator` with a block
    # that will be called as the parameter for
    # Enumerator.new
    class WithEnumeratorGenerator < ::Croupier::DistributionGenerator

      method_name "with_enumerator"

      def initilize distribution, &block
        super distribution, &block
      end

      def to_enum
        Enumerator.new do |y|
          self.distribution.instance_exec(y,&self.block)
        end.lazy
      end
    end
  end
end