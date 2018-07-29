require 'bundler/setup'
require 'itexmo'
require 'byebug'
require 'simplecov'
require 'simplecov-console'
require 'webmock/rspec'
require 'dotenv'

Dotenv.load

SimpleCov.formatter = SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
