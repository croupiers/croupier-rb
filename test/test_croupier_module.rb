require "croupier"
class TestCroupierModule < MiniTest::Unit::TestCase

  def test_module_manages_a_croupier_cli_application_object
    app = Croupier.application
    assert_kind_of Croupier::CLI::Application, app
  end

  def test_accepts_setting_an_external_croupier_cli_application
    app = Croupier::CLI::Application.new
    Croupier.application = app
    assert Croupier.application == app
  end

end