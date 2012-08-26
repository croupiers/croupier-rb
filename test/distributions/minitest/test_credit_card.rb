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

  def test_initial_numbers_are_placed_at_beginning
    assert_equal "2345", credit_card(initial_values: "2345")[0..3]
  end

  def test_initial_numbers_are_placed_after_card_type_if_one_is_given
    assert_equal "62345", credit_card(discover: true, initial_values: "2345")[0..4]
  end

  def test_initial_numbers_get_not_numbers_removed_before_placing_them
    assert_equal "2345", credit_card(initial_values: "a2b3c4d5e")[0..3]
  end
end
