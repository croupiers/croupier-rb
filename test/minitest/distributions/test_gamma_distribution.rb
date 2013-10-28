require "minitest/autorun"
require "croupier"
class TestGammaDistribution < Minitest::Test

  def gamma *args
    ::Croupier::Distributions.gamma *args
  end

  def test_shape_returns_right_shape
    g = gamma shape: 5.3, scale: 3.1
    assert_in_delta 5.3, g.shape, 1e-10, "shape is not right"
  end

  def test_scale_returns_right_scale
    g = gamma shape: 5.3, scale: 3.1
    assert_in_delta 3.1, g.scale, 1e-10, "scale is not right"
  end

  def test_delta_is_correct_delta
    g = gamma shape: 5.3, scale: 3.1
    assert_in_delta 0.3, g.delta, 1e-10, "delta is not right"
  end
end