require "minitest/autorun"
require "croupier"
class TestBinomialDistribution < MiniTest::Unit::TestCase

  def binomial *args
    ::Croupier::Distributions.binomial *args
  end

  def test_success_returns_correct_success
    b = binomial size: 15, success: 0.3
    assert_in_delta 0.3, b.success, 0e-10, "success is not right"
  end

  def test_size_returns_correct_size
    b = binomial size: 15, success: 0.3
    assert_equal 15, b.size
  end
end