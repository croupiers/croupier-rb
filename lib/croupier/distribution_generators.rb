module Croupier
  module DistributionGenerators
    class << self
      # An array containing all available Distribution classes
      def all
        ::Croupier::DistributionGenerators.constants(false).each_with_object([]){|distrib,list|
          d = ::Croupier::DistributionGenerators.const_get(distrib)
          list << d if (d.is_a?(Class) && d.superclass == Croupier::DistributionGenerator)
        }.uniq.compact
      end

      # list of all available distribution names (and methods on Distributions module)
      def list
        self.all.map(&:method_name).sort
      end
    end
  end
end