require "minitest/autorun"
require "croupier"
class TestExponentialDistribution < MiniTest::Unit::TestCase

  def exponential *args
    ::Croupier::Distributions.exponential *args
  end

  def test_lambda_returns_params_lambda
    e = exponential lambda: 30.3
    assert_in_delta 30.3, e.lambda, 0e-10, "lambda is not right"
  end
end