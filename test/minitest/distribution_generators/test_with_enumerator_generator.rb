require 'rubygems'
require 'pry'
require "minitest/autorun"
require "croupier"

class TestWithEnumeratorGenerator < MiniTest::Unit::TestCase

  def setup
    @klazz = Class.new(::Croupier::Distribution) do
      def my_num
        2
      end
    end
    @distribution = @klazz.new
    @block = ->(y) { y << my_num while true }
    @gen = ::Croupier::DistributionGenerators::WithEnumeratorGenerator.new @distribution, &@block
  end

  def test_initialize_calls_super_and_it_works
    assert_equal @distribution, @gen.distribution
    assert_equal @block, @gen.block
  end

  def test_to_enum_calls_the_block
    assert_kind_of Enumerator, @gen.to_enum
    assert_equal 2, @gen.to_enum.first
  end

  def test_block_can_access_methods_in_distribution
    assert_kind_of Enumerator, @gen.to_enum
    assert_equal 2, @gen.to_enum.first
  end
end