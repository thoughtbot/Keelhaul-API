module FixtureHelpers
  def fixture_for(name)
    File.read("spec/support/fixtures/#{name}")
  end
end

RSpec.configure do |config|
  config.include FixtureHelpers
end
