require "minitest/autorun"
require "croupier"
class TestPoissonDistribution < Minitest::Test

  def poisson *args
    ::Croupier::Distributions.poisson *args
  end

  def test_lambda_gets_correct_value
    p = poisson lambda: 10.1
    assert_equal 10.1, p.lambda, "lambda is not right"
  end
end