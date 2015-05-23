require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.default_formatter = 'doc' if config.files_to_run.one?
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.profile_examples = 5
  config.warnings = false
  config.platform = 'ubuntu'
  config.version = '14.04'
  config.order = :random
  Kernel.srand config.seed
end

ChefSpec::Coverage.start! if ENV['COVERAGE']
