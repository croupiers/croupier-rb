require "minitest/autorun"
require "croupier"
class TestDegenerateDistribution < Minitest::Test

  def test_distribution_has_name_and_description
    dist = Croupier::Distributions::Degenerate.new
    assert_respond_to dist, 'name'
    assert_respond_to dist, 'description'
  end

  def test_returns_only_one_value
    dist = Croupier::Distributions::Degenerate.new constant: 5.34
    5.times do
      assert_equal 5.34, dist.generate_number
    end
  end

  def test_to_enum
    enum = Croupier::Distributions::Degenerate.new(constant: 5).to_enum
    assert_kind_of Enumerator, enum
    assert_equal [5,5,5], enum.take(3).to_a
  end
end
