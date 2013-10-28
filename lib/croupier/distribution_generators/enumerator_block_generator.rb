module Croupier

  module DistributionGenerators

    # Call `enumerator_block` with a block
    # that will be called as the parameter for
    # Enumerator.new
    class EnumeratorBlockGenerator < ::Croupier::DistributionGenerator

      method_name "enumerator_block"

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