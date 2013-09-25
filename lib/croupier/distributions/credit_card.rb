module Croupier
  module Distributions

    #####################################################################
    # CreditCard Distribution
    # Continuous probability distribution describing resonance behavior.
    #
    class CreditCard < ::Croupier::Distribution

      distribution_name "CreditCard distribution"

      distribution_description "Generates random credit card numbers."

      cli_name "credit_card"

      cli_option :master_card, 'master card type', {type: :boolean, default: false}
      cli_option :american_express, 'american express card type', {type: :boolean, default: false}
      cli_option :visa, 'visa card type', {type: :boolean, default: false}
      cli_option :discover, 'discover card type', {type: :boolean, default: false}
      cli_option :initial_values, 'initial values for the credit card. They will be placed after card type if one is given.', {type: :string, default: ""}

      cli_banner "Credit Card distribution. Generate random card numbers"

      # Returns a lambda that completes
      # the credit card number up to
      # 15 numbers.
      def fill_number
        ->(n) { "#{n}#{generate_random_string(15-n.size)}"[0..14] }
      end

      # Returns a lambda that adds
      # the checksum number
      def add_checksum
        ->(n) { "#{n}#{check_digit_for(n)}" }
      end

      enumerator do |c|
        c.degenerate(constant: init).map(&fill_number).map(&add_checksum)
      end

      def initialize(options={})
        super(options)
      end

      def init
        "#{initial_value_by_card_type}#{initial_values}"
      end

      def generate_number
        n = "#{initial_value_by_card_type}#{initial_values}"
        n += generate_random_string(15 - n.size)
        n = n[0..14]
        n + check_digit_for(n).to_s
      end

      def check_digit_for(n)
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
    end
  end
end
