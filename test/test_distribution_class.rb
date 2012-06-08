require "croupier"
class TestDistributionClass < MiniTest::Unit::TestCase

  def test_distribution_has_name_and_description
    dist = Croupier::Distribution.new
    assert_respond_to dist, 'name'
    assert_respond_to dist, 'description'
  end
  
  def test_distribution_accepts_parameter_configuration
    dist = Croupier::Distribution.new
    assert_equal dist.parameters, dist.default_parameters
    dist.configure({:larry => 'bird', :leonard => 'euler'})
    refute_equal dist.parameters, dist.default_parameters
    assert_equal dist.parameters[:larry], 'bird'
    assert_equal dist.parameters[:leonard], 'euler'
  end
  
  def test_distribution_has_trollop_options_info
    assert_respond_to Croupier::Distribution, 'cli_name'
    assert_respond_to Croupier::Distribution, 'cli_options'
  end
  
  def test_distribution_generates_array_of_n_results
    assert_equal Croupier::Distribution.new.generate_numbers(15).size, 15
  end

end