require "minitest/autorun"
require "croupier"
class TestBinomialDistribution < MiniTest::Unit::TestCase

  def bernoulli *args
    ::Croupier::Distributions.bernoulli *args
  end

  def test_success_returns_correct_success
    b = bernoulli success: 0.3
    assert_in_delta 0.3, b.success, 0e-10, "success is not right"
  end
end