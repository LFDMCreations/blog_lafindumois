require "database_cleaner-sequel"

# Hanami.app.prepare(:persistence)
DatabaseCleaner[:sequel, db: Hanami.app["persistence.db"]]
DatabaseCleaner[:sequel].db = Sequel.connect('postgres://thiebo@localhost:5432/lafindumois_blog_test')

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each, type: :database) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end