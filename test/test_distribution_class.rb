require "minitest/autorun"
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
    a = Croupier::Distribution.new
    def a.generate_number; 15; end
    assert_equal a.generate_sample(15).size, 15
  end

  def test_generate_number_calls_inv_pdf_if_present
    c = Class.new(Croupier::Distribution) do
      def inv_pdf n; true; end
      def generate_sample n; false; end
    end
    a = c.new
    assert a.generate_number
  end

  def test_generate_sample_calls_inv_pdf_if_present
    c = Class.new(Croupier::Distribution) do
      def inv_pdf n; true; end
      def generate_number n; false; end
    end
    a = c.new
    assert a.generate_sample(3).all?
  end
end
