require "minitest/autorun"
require "croupier"
class TestInverseCdfGenerator < Minitest::Test

  def setup
    @distribution = ::Croupier::Distribution.new
    @block = ->(n) { 2+n }
    @gen = ::Croupier::DistributionGenerators::InverseCDFGenerator.new @distribution, &@block
  end

  def test_initialize_calls_super_and_it_works
    assert_equal @distribution, @gen.distribution
    assert_equal @block, @gen.block
  end

  def test_to_enum_calls_the_block
    @gen.to_enum.take(10).each do |n|
      assert_operator 2, :<=, n, "#{n} is not at least 2"
      assert_operator 3, :>, n, "#{n} is not strictly less than 3"
    end
  end

  def test_block_can_access_methods_in_distribution
    @distribution = Class.new(::Croupier::Distribution) do
      def my_method n
        2
      end
    end

    @block = ->(n) { my_method n }

    @gen = ::Croupier::DistributionGenerators::InverseCDFGenerator.new @distribution.new, &@block

    assert_equal [2,2,2,2], @gen.to_enum.take(4).to_a
  end
end