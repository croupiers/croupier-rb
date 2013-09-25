require "minitest/autorun"
require "croupier"
class TestDistributionClassInstanceMethods < Minitest::Test

  def test_distribution_has_name_and_description
    dist = Croupier::Distribution.new
    assert_respond_to dist, 'name'
    assert_respond_to dist, 'description'
  end

  def test_name_returns_distribution_name
    dist = Class.new Croupier::Distribution do
      distribution_name "Dist"
    end
    sample = dist.new
    assert_equal "Dist", sample.name
  end

  def test_description_returns_distribution_description
    dist = Class.new Croupier::Distribution do
      distribution_description "Desc"
    end
    sample = dist.new
    assert_equal "Desc", sample.description
  end

  def test_distribution_accepts_parameter_configuration
    dist = Croupier::Distribution.new
    assert_equal dist.parameters, dist.default_parameters
    dist.configure({larry: 'bird', leonard: 'euler'})
    refute_equal dist.parameters, dist.default_parameters
    assert_equal dist.parameters[:larry], 'bird'
    assert_equal dist.parameters[:leonard], 'euler'
  end

  def test_distribution_has_trollop_options_info
    assert_respond_to Croupier::Distribution, 'cli_name'
    assert_respond_to Croupier::Distribution, 'cli_options'
  end

  def test_distribution_generates_array_of_n_results
    u = Croupier::Distributions.uniform
    assert_equal u.generate_sample(15).size, 15
  end

  def test_initialize_creates_a_generator
    c = Class.new(Croupier::Distribution) do
      inv_cdf do |n|
        2
      end
    end

    d = c.new
    assert_kind_of ::Croupier::DistributionGenerators::InverseCDFGenerator, d.generator
  end

  # What The Fuck
  # Making ::Croupier::Distribution a subclass of Enumerator::Lazy
  # is a fucking hell. Impossible, as far as I am concerned.
  # Yes, I can say fucking since trying to do so made MRI to break
  # and cry like Captain Hammer at the end of Dr. Horrible.
  # If Enumerable gets just included, we lose the lazy part.
  #
  # My solution, bang my head against the train window and then
  # delegate all the methods to the enum.
  def test_distribution_is_enumerable
    dist = ::Croupier::Distribution.new

    assert_respond_to dist, :each, "distribution does not respond to each"
    Enumerable.instance_methods.each do |method|
      assert_respond_to dist, method, "distribution does not respond to #{method}"
    end
  end
end
