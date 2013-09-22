require "minitest/autorun"
require "croupier"
class TestNormalDistribution < MiniTest::Unit::TestCase
  def normal *args
    ::Croupier::Distributions.normal *args
  end

  def test_mean_returns_mean
    n = normal std: 1, mean: 23.2
    assert_in_delta 23.2, n.mean, 0e-10, "mean is right"
  end

  def test_std_returns_standard_deviation
    n = normal std: 1.23, mean: 2
    assert_in_delta 1.23, n.std, 0e-10, "standard deviation is right"
  end
end