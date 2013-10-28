module Croupier

  module Distributions
    class << self
      # An array containing all available Distribution classes
      def all
        ::Croupier::Distributions.constants(false).each_with_object([]){|distrib, list|
          d = ::Croupier::Distributions.const_get(distrib)
          list << d if (d.is_a?(Class) && d.superclass == Croupier::Distribution)
        }.uniq.compact
      end

      # list of all available distribution names (and methods on Distributions module)
      def list
        self.all.map(&:cli_name).sort
      end

      def method_missing(method, *args, &block) # :nodoc:
        return super unless self.respond_to?(method)
        self.all.find{|d| d.cli_name == method.to_s}.new(*args)
      end

      def respond_to?(method, include_private = false) # :nodoc:
        self.list.include?(method.to_s) || super(method, include_private)
      end
    end
  end
end