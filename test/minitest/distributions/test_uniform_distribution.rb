require "minitest/autorun"
require "croupier"
class TestUniformDistribution < MiniTest::Unit::TestCase

  def uniform(opts={})
    ::Croupier::Distributions.uniform(opts)
  end

  def test_inverted_for_default_uniform
    u = uniform
    assert !u.inverted?, "uniform should not be considered inverted"
  end

  def test_inverted_for_uniform_where_included_smaller_than_excluded
    u = uniform included: 5, excluded: 7
    assert !u.inverted?, "uniform should not be considered inverted"
  end

  def test_inverted_for_uniform_where_included_greater_than_excluded
    u = uniform({included: 7, excluded: 5})
    assert u.inverted?, "uniform should be considered inverted"
  end

  def test_minmax_and_range_in_default_uniform
    u = uniform
    assert_equal 0, u.min, "default minimum is not 0"
    assert_equal 1, u.max, "default maximum is not 1"
    assert_equal 1, u.range, "default range is not 1"
  end

  def test_minmax_and_range_in_non_inverted_uniform
    u = uniform included: 5, excluded: 7
    assert_equal 5, u.min, "minimum is not the included value"
    assert_equal 7, u.max, "maximum is not the excluded value"
    assert_equal 2, u.range, "range is not maximum - minimum"
  end

  def test_minmax_and_range_in_inverted_uniform
    u = uniform included: 7, excluded: 5
    assert_equal 5, u.min, "minimum is not the excluded value"
    assert_equal 7, u.max, "maximum is not the included value"
    assert_equal 2, u.range, "range is not maximum - minimum"
  end

  def test_exclude_value_for_non_inverted_distributions
    u = uniform
    assert_in_delta 0.3, u.exclude_value.(0.3), 1e-10, "exclude value function is not the identity"
  end

  def test_exclude_value_for_inverted_distributions
    u = uniform included: 7, excluded: 5
    assert_in_delta 0.7, u.exclude_value.(0.3), 1e-10, "exclude value function is not 1-n"
  end
end