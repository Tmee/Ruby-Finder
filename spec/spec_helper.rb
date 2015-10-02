require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)


OmniAuth.config.test_mode = true
  omniauth_hash = { 'provider' => 'twitter',
                    'uid' => '12345',
                    'info' => {
                        'name' => 'Tim',
                        'email' => 'Tim@example.com',
                        'nickname' => 'MeeTim'
                    }
                  }
OmniAuth.config.add_mock(:twitter, omniauth_hash)



RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

=begin
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
=end
end
