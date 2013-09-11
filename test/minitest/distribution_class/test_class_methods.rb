require 'minitest/autorun'
require 'croupier'

class TestDistributionClassClassMethods < MiniTest::Unit::TestCase

  def distribution_subclass_with_name name
    Class.new Croupier::Distribution do
      distribution_name name
    end
  end

  def distribution_subclass_with_description description
    Class.new Croupier::Distribution do
      distribution_description description
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

  def test_description_setter_adds_the_description
    a = distribution_subclass_with_description "My desc"
    assert_equal "My desc", a.distribution_description
  end

  def test_description_sets_separated_descriptions_for_each_subclass
    a = distribution_subclass_with_description "A"
    b = distribution_subclass_with_description "B"
    assert_equal "A", a.distribution_description
    assert_equal "B", b.distribution_description
    assert_nil Croupier::Distribution.distribution_description
  end
end