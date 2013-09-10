require 'minitest/autorun'
require 'croupier'

class TestDistributionClassClassMethods < MiniTest::Unit::TestCase

  def distribution_subclass_with_name name
    Class.new Croupier::Distribution do
      distribution_name name
    end
  end

  def test_name_setter_adds_the_name
    a = distribution_subclass_with_name "My name"
    assert_equal "My name", a.distribution_name
  end

  def test_name_sets_separated_names_for_each_subclass
    a = distribution_subclass_with_name "A"
    b = distribution_subclass_with_name "B"
    assert_equal "A", a.distribution_name
    assert_equal "B", b.distribution_name
    assert_nil Croupier::Distribution.distribution_name
  end
end