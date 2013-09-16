module Croupier

  module DistributionGenerators

    class InverseCDFGenerator < ::Croupier::DistributionGenerator

      method_name "inv_cdf"

      def initilize distribution, &block
        super distribution, &block
      end

      def to_enum
        # Fix when final api is availble
        croupier.uniform.to_enum.lazy.map do |n|
          distribution.instance_exec(n, &self.block)
        end
      end
    end
  end
end