require "minitest/autorun"
require "croupier"
class TestDistributionsModule < Minitest::Test

  def test_list_of_all_distributions
    all = Croupier::Distributions.all

    assert all.size > 1

    all.each{|d|
      assert d.superclass == Croupier::Distribution
    }

    Croupier::Distributions.constants(false).each do |distrib|
      d = ::Croupier::Distributions.const_get(distrib)
      if d.is_a?(Class) && d.superclass == Croupier::Distribution
        assert all.include?(d), "#{d.name} not included in array of all distributions"
      end
    end
  end

  def test_cli_names_list
    list = Croupier::Distributions.list
    Croupier::Distributions.all.each{|d|
      assert list.include?(d.cli_name), "#{d.cli_name} not included in list"
    }
  end

  def test_all_and_list_have_same_size
    all = Croupier::Distributions.all
    list = Croupier::Distributions.list
    assert list.size == all.size
  end

  def test_dynamic_distribution_methods
    Croupier::Distributions.list.each{|method|
      assert Croupier::Distributions.respond_to?(method), "No response for #{method} method"
    }
  end

  def test_dynamic_method_returns_right_distribution
    Croupier::Distributions.list.each do |method|
      distrib = Croupier::Distributions.send method
      assert_equal distrib.class.cli_name, method
    end

    example = Croupier::Distributions.normal :mean => 33, :std => 21
    assert_equal example.parameters[:mean], 33
    assert_equal example.parameters[:std], 21
  end

end