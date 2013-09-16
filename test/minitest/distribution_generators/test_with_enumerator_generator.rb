require 'rubygems'
require 'pry'
require "minitest/autorun"
require "croupier"

class TestWithEnumeratorGenerator < MiniTest::Unit::TestCase

  def setup
    @klazz = Class.new(::Croupier::Distribution) do
      def my_enum
        @my_enum ||= Enumerator.new do |y| b = 0; loop do y<<b; b+=1; end; end
      end
    end
    @distribution = @klazz.new
    @enum = @distribution.my_enum
    @block = ->() { my_enum }
    @gen = ::Croupier::DistributionGenerators::WithEnumeratorGenerator.new @distribution, &@block
  end

  def test_initialize_calls_super_and_it_works
    assert_equal @distribution, @gen.distribution
    assert_equal @block, @gen.block
  end

  def test_to_enum_calls_the_block
    assert_same @enum, @gen.to_enum
  end

  def test_block_can_access_methods_in_distribution
    @distribution = Class.new(::Croupier::Distribution) do
      def my_method
        2
      end
    end

    @block = ->() { my_method }

    @gen = ::Croupier::DistributionGenerators::WithEnumeratorGenerator.new @distribution.new, &@block

    assert_equal 2, @gen.to_enum
  end
end