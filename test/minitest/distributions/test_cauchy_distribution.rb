require "minitest/autorun"
require "croupier"
class TestCauchyDistribution < MiniTest::Unit::TestCase

  def cauchy *args
    ::Croupier::Distributions.cauchy *args
  end

  def test_location_returns_correct_location
    c = cauchy location: 3.1, scale: 5.2
    assert_in_delta 3.1, c.location, 1e-10, "location is not right"
  end

  def test_scale_returns_correct_scale
    c = cauchy location: 3.1, scale: 5.2
    assert_in_delta 5.2, c.scale, 1e-10, "scale is not right"
  end
end