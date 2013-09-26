require "minitest/autorun"
require "croupier"

class TestDistributionClassClassMethods < Minitest::Test

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

  def distribution_subclass_with_generator_class klazz
    Class.new Croupier::Distribution do
      generator_class klazz
    end
  end

  def distribution_subclass_with_generator_block &block
    Class.new Croupier::Distribution do
      generator_block &block
    end
  end

  def distribution_subclass_with_cli_options opts
    Class.new Croupier::Distribution do
      cli_options opts
    end
  end

  def distribution_subclass_with_cli_banner banner
    Class.new Croupier::Distribution do
      cli_banner banner
    end
  end

  def distribution_subclass_with_cli_name name
    Class.new Croupier::Distribution do
      cli_name name
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

  def test_cli_name_setter_adds_the_cli_name
    a = distribution_subclass_with_cli_name "name"
    assert_equal "name", a.cli_name
  end

  def test_cli_name_sets_separated_names_for_each_subclass
    a = distribution_subclass_with_cli_name "a"
    b = distribution_subclass_with_cli_name "b"
    assert_equal "a", a.cli_name
    assert_equal "b", b.cli_name
    assert_nil Croupier::Distribution.cli_name
  end

  def test_cli_banner_setter_adds_the_cli_banner
    a = distribution_subclass_with_cli_banner "Instructions for use of this Distribution"
    assert_equal "Instructions for use of this Distribution", a.cli_options[:banner]
  end

  def test_cli_banner_sets_separated_banners_for_each_subclass
    a = distribution_subclass_with_cli_banner "a"
    b = distribution_subclass_with_cli_banner "b"
    assert_equal "a", a.cli_options[:banner]
    assert_equal "b", b.cli_options[:banner]
    assert_nil Croupier::Distribution.cli_options[:banner]
  end

  def test_cli_option_setter_adds_a_cli_option
    option = [:abc, "prints ABC", {}]
    a = distribution_subclass_with_name "Test"
    a.cli_option option[0], option[1], option[2]
    assert_equal [option], a.cli_options[:options]
  end

  def test_cli_option_does_not_delete_previous_cli_options
    opts = {banner: 'Hey', options: [[:a, "A", {type: :boolean}], [:b, "B", {type: :float}]]}
    option  = [:abc, "prints ABC", {}]
    a = distribution_subclass_with_cli_options opts
    a.cli_option option[0], option[1], option[2]
    assert_equal (opts[:options] << option), a.cli_options[:options]
  end

  def test_cli_option_adds_separated_option_for_each_subclass
    optionA = [:abc, "prints ABC", {}]
    optionB = [:xyz, "prints XYZ", {type: :boolean}]
    a = distribution_subclass_with_name "A"
    b = distribution_subclass_with_name "B"
    a.cli_option optionA[0], optionA[1], optionA[2]
    b.cli_option optionB[0], optionB[1], optionB[2]
    assert_equal [optionA], a.cli_options[:options]
    assert_equal [optionB], b.cli_options[:options]
    assert_empty Croupier::Distribution.cli_options
  end

  def test_cli_option_adds_instance_method
    a = distribution_subclass_with_name "A"
    a.cli_option :cowabunga, "TMNT", {type: :float}
    assert_respond_to a.new, :cowabunga
  end

  def test_cli_options_adds_instance_method_with_modified_name
    a = distribution_subclass_with_name "A"
    a.cli_option :are_you_my_mummy, "Doctor Who", {type: :boolean}
    assert_respond_to a.new, :are_you_my_mummy?
  end

  def test_cli_option_defines_an_accessor
    a = distribution_subclass_with_name "A"
    a.cli_option :cowabunga, "TMNT", {type: :float}
    instance = a.new cowabunga: 1.3
    assert_equal 1.3, instance.cowabunga
  end

  def test_cli_options_setter_adds_the_options
    opts = Hash.new
    a = distribution_subclass_with_cli_options opts
    assert_equal opts, a.cli_options
  end

  def test_default_parameters_correctly_computed_from_cli_options
    opts = {banner: 'Something', options: [[:a, "A", {type: :float, default: 0.5}], [:b, "B", {type: :float, default: 0.7}]]}
    a = distribution_subclass_with_cli_options opts
    assert_equal 0.5, a.default_parameters[:a]
    assert_equal 0.7, a.default_parameters[:b]
  end

  def test_cli_options_sets_separated_cli_options_for_each_subclass
    ha = Hash.new
    hb = Hash.new
    a = distribution_subclass_with_cli_options ha
    b = distribution_subclass_with_cli_options hb
    assert_equal ha, a.cli_options
    assert_equal hb, b.cli_options
    assert_empty Croupier::Distribution.cli_options
  end

  def test_responds_to_generators_methods
    assert_respond_to ::Croupier::Distribution, 'inv_cdf'
    assert_respond_to ::Croupier::Distribution, 'minimum_sample'
    assert_respond_to ::Croupier::Distribution, 'enumerator_block'
    assert_respond_to ::Croupier::Distribution, 'enumerator'
  end

  def test_generator_class_setter_adds_generator_class
    klazz = Class.new
    a = distribution_subclass_with_generator_class klazz
    assert_equal klazz, a.generator_class
  end

  def test_generator_class_sets_separated_classes_for_each_subclass
    ka = Class.new
    kb = Class.new
    a = distribution_subclass_with_generator_class ka
    b = distribution_subclass_with_generator_class kb
    assert_equal ka, a.generator_class
    assert_equal kb, b.generator_class
    assert_nil Croupier::Distribution.generator_class
  end

  def test_generator_block_setter_adds_generator_class
    block = -> { 2 }
    a = distribution_subclass_with_generator_block &block
    assert_equal block, a.generator_block
  end

  def test_generator_block_sets_separated_blocks_for_each_subclass
    pa = -> { 2 }
    pb = -> { 3 }
    a = distribution_subclass_with_generator_block &pa
    b = distribution_subclass_with_generator_block &pb
    assert_equal pa, a.generator_block
    assert_equal pb, b.generator_block
    assert_nil Croupier::Distribution.generator_block
  end
end