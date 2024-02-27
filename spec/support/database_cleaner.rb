# frozen_string_literal: true

require 'database_cleaner-sequel'
require_relative '../../config/config'

# Hanami.app.prepare(:persistence)
# DatabaseCleaner[:sequel, db: Hanami.app["persistence.db"]]
DatabaseCleaner[:sequel].db = Sequel.connect('postgres://lafindumois_development@localhost/lafindumois_blog_test')

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # config.after(:suite) do
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
