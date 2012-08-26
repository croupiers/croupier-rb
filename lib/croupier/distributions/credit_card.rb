module Croupier
  module Distributions

    #####################################################################
    # CreditCard Distribution
    # Continuous probability distribution describing resonance behavior.
    #
    class CreditCard < ::Croupier::Distribution

      def initialize(options={})
        @name = "CreditCard distribution"
        @description = "Generates random credit card numbers."
        configure(options)
      end

      def generate_number
        n = "#{initial_value_by_card_type}#{initial_values}"
        n += generate_random_string(15 - n.size)
        n = n[0..14]
        n + check_number_for(n).to_s
      end

      def default_parameters
        {
          :master_card => false,
          :american_express => false,
          :discover => false,
          :visa => false,
          :initial_values => ""
        }
      end

      def self.cli_name
        "credit_card"
      end

      def check_number_for(n)
        # Sum, every odd number should be doubled.
        # If result has two digits, they should be summed up.
        # This is equivalent to substracting 9
        x = n.each_char.map do |x|
          x.to_i
        end.each_with_index.map do |x, i|
          if i.even?
            x = 2*x
            (x >= 10) ? x - 9 : x
          else
            x
          end
        end.inject(&:+) % 10

        return 0 if x == 0
        10 - x
      end

      def generate_random_string l
        (1..l).map{ rand(10).to_s }.join ''
      end

      def initial_values
        params[:initial_values].gsub /\D/, ''
      end

      def initial_value_by_card_type
        return 3 if params[:american_express]
        return 4 if params[:visa]
        return 5 if params[:master_card]
        return 6 if params[:discover]
        ""
      end

      def self.cli_options
        {:options => [
           [:master_card, 'master card type', {:type=>:boolean, :default => false}],
           [:american_express, 'american express card type', {:type=>:boolean, :default => false}],
           [:visa, 'visa card type', {:type=>:boolean, :default => false}],
           [:discover, 'discover card type', {:type=>:boolean, :default => false}],
           [:initial_values, 'initial values for the credit card. They will be place after card type if one is given.', {:type=>:string, :default => ""}]
         ],
         :banner => "Credit Card distribution. Generate random card numbers"
        }
      end
    end
  end
end
