require "minitest/autorun"
require "croupier"

class DistributionGeneratorClassClassMethods < Minitest::Test

  def create_generator_with_method_name name
    Class.new Croupier::DistributionGenerator do
      method_name name
    end
  end

  def test_method_name_setter_sets_the_name
    gen = create_generator_with_method_name "method_name"
    assert_equal "method_name", gen.method_name
  end

  def test_method_name_sets_different_names_for_each_subclass
    a = create_generator_with_method_name "method_a"
    b = create_generator_with_method_name "method_b"
    assert_equal "method_a", a.method_name
    assert_equal "method_b", b.method_name
    assert_nil Croupier::DistributionGenerator.method_name
  end
end