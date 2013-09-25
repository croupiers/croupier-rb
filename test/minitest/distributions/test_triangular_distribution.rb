require "minitest/autorun"
require "croupier"
class TestTriangularDistribution < Minitest::Test

  def triangular(opts={})
    ::Croupier::Distributions.triangular(opts)
  end

  def test_change_lower_and_upper_values_if_they_are_not_in_the_right_order
    t = triangular lower: 8, upper: 3, mode: 4
    assert_equal 3, t.lower, "lower is not 3"
    assert_equal 8, t.upper, "upper is not 8"
    assert_equal 5, t.range, "range is not upper - limit"
  end

  def test_change_mode_if_lt_lower_value
    t = triangular lower: 3, upper: 6, mode: 2
    assert_in_delta 4.5, t.mode, 1e-10, "mode did not change to median"
  end

  def test_change_mode_if_gt_upper_value
    t = triangular lower: 3, upper: 6, mode: 8
    assert_in_delta 4.5, t.mode, 1e-10, "mode did not change to median"
  end
end

