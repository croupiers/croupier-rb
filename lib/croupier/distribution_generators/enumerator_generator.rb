module Croupier

  module DistributionGenerators

    # Call `enumerator` with a block
    # that returns an enumerator.
    # First block argument is the Croupier::Distributions module
    class EnumeratorGenerator < ::Croupier::DistributionGenerator

      method_name "enumerator"

      def initilize distribution, &block
        super distribution, &block
      end

      def to_enum
        self.distribution.instance_exec(::Croupier::Distributions, &self.block).lazy
      end
    end
  end
end