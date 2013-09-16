require "minitest/autorun"
require "croupier"

class DistributionGeneratorClassIntanceMethods < MiniTest::Unit::TestCase

  def setup
    @distribution = Croupier::Distribution.new
    @params = @distribution.parameters
    @block = Proc.new { }
    @generator = Croupier::DistributionGenerator.new @distribution, &@block
    def @generator.generate_minimum_sample
      [1,2,3]
    end
  end

  def test_parameters_returns_distribution_parameters
    assert_same @params, @generator.params
  end

  def test_distribution_accessor
    assert_equal @distribution, @generator.distribution
  end

  def test_block_accessor
    assert_equal @block, @generator.block
  end

  def test_croupier_method_returns_distributions
    assert_same Croupier::Distributions, @generator.croupier
  end

  def test_to_enum
    assert_equal [1,2,3,1,2], @generator.to_enum.take(5)
  end
end