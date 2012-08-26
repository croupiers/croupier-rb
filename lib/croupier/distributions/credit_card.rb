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
        "#{initial_value_by_card_type}#{initial_values}"
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
