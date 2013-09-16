require "minitest/autorun"
require "croupier"

class TestDistributionGeneratorsModule < MiniTest::Unit::TestCase

  def test_list_of_all_distribution_generators
    all = Croupier::DistributionGenerators.all

    assert_operator all.size, :>, 1, "#{all.size} is 1 or less"

    all.each{|d|
      assert_equal Croupier::DistributionGenerator, d.superclass, "#{d.name} is not a distribution generator"
    }

    Croupier::DistributionGenerators.constants(false).each do |distrib|
      d = ::Croupier::DistributionGenerators.const_get(distrib)
      if d.is_a?(Class) && d.kind_of?(Croupier::DistributionGenerator)
        assert_includes all, d, "#{d.name} not included in array of all distributions"
      end
    end
  end

  def test_method_names_list
    list = Croupier::DistributionGenerators.list
    assert_operator list.size, :>, 1, "#{list.size} is 1 or less"
    Croupier::DistributionGenerators.all.each{|d|
      assert_includes list, d.method_name, "#{d.method_name} not included in list"
    }
  end
  
  def test_all_and_list_have_same_size
    all = Croupier::DistributionGenerators.all
    list = Croupier::DistributionGenerators.list
    assert_operator list.size, :>, 1, "#{list.size} is 1 or less"
    assert_equal list.size, all.size, "#{list.size} and #{all.size} are not equal"
  end
end