require "minitest/autorun"
require "croupier"
class TestDistributionClass < MiniTest::Unit::TestCase

  def valid_options(optional={})
    {}.merge(optional)
  end

  def credit_card(options={})
    Croupier::Distributions::CreditCard.new(valid_options(options)).generate_number
  end

  def test_distribution_has_name_and_description
    dist = Croupier::Distributions::CreditCard.new
    assert_respond_to dist, 'name'
    assert_respond_to dist, 'description'
  end

  def test_init_method
    c = Croupier::Distributions::CreditCard.new visa: true, initial_values: "5678"
    assert_equal "45678", c.init
  end

  def test_visa_starts_with_4
    assert_equal "4",  credit_card(visa: true)[0]
  end

  def test_american_express_starts_with_3
    assert_equal "3", credit_card(american_express: true)[0]
  end

  def test_master_card_starts_with_5
    assert_equal "5", credit_card(master_card: true)[0]
  end

  def test_discover_starts_with_6
    assert_equal "6", credit_card(discover: true)[0]
  end

  def test_initial_values_are_placed_at_beginning
    assert_equal "2345", credit_card(initial_values: "2345")[0..3]
  end

  def test_initial_values_are_placed_after_card_type_if_one_is_given
    assert_equal "62345", credit_card(discover: true, initial_values: "2345")[0..4]
  end

  def test_initial_values_get_not_numbers_removed_before_placing_them
    assert_equal "2345", credit_card(initial_values: "a2b3c4d5e")[0..3]
  end

  def test_generate_numbers_for_getting_a_15_chars_long_string
    assert_equal 16, credit_card.size
    assert_equal 16, credit_card(visa: true).size
    assert_equal 16, credit_card(initial_values: "234566789-32").size
    assert_equal 16, credit_card(initial_values: "01234567890123456789").size
  end

  def test_check_digit
    assert_equal "2", credit_card(initial_values: "1234 5678 9012 345")[-1]
    assert_equal "7", credit_card(initial_values: "1111 1111 1111 111")[-1]
    assert_equal "8", credit_card(initial_values: "1111 1111 1111 101")[-1]
    assert_equal "2", credit_card(visa: true, initial_values: "602das63276315242666")[-1]
  end
end
