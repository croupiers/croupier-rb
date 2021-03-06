require "minitest/autorun"
require "croupier"
class TestGeometricDistribution < Minitest::Test

  def geometric *args
    ::Croupier::Distributions.geometric *args
  end

  def test_success_returns_success_param
    g = geometric success: 0.7
    assert_in_delta 0.7, g.success, 1e-10, "success is right param"
  end
end