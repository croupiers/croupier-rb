require "minitest/autorun"
require "croupier"
class TestMinimumSampleGenerator < MiniTest::Unit::TestCase

  def setup
    @distribution = ::Croupier::Distribution.new
    @block = ->() { [1,2,3] }
    @gen = ::Croupier::DistributionGenerators::MinimumSampleGenerator.new @distribution, &@block
  end

  def test_initialize_calls_super_and_it_works
    assert_equal @distribution, @gen.distribution
    assert_equal @block, @gen.block
  end

  def test_to_enum_calls_the_block
    assert_equal [1,2,3,1,2,3,1], @gen.to_enum.take(7).to_a
  end

  def test_block_can_access_methods_in_distribution
    @distribution = Class.new(::Croupier::Distribution) do
      def my_method
        [1,2,3]
      end
    end.new

    @block = ->() { my_method }

    @gen = ::Croupier::DistributionGenerators::MinimumSampleGenerator.new @distribution, &@block

    assert_equal [1,2,3,1], @gen.to_enum.take(4).to_a
  end
end