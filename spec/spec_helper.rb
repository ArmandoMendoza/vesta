ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # config.include FeatureHelpers, type: :feature
  config.mock_with :rspec
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false

  DatabaseCleaner.logger = Rails.logger

  config.before(:each) do
    DatabaseCleaner[:active_record].strategy = if example.metadata[:js]
      :truncation
    else
      :transaction
    end
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end