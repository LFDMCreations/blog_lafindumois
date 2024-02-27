# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.4', '>= 6.4.2'
gem 'rackup', '~> 2.1'
gem 'sequel', '~> 5.77'
gem 'sinatra', '~> 4.0'
gem 'sinatra-contrib', '~> 4.0'

gem 'rubocop', require: false
gem 'rubocop-rspec', '~> 2.26', '>= 2.26.1', require: false
gem 'rubocop-sequel', '~> 0.3.4', require: false

group :development do
  gem 'localhost'
end

group :test, :development do
  gem 'racksh', '~> 1.0', '>= 1.0.1'
  gem 'rack-unreloader', '~> 2.1'
end

group :test do
  gem 'database_cleaner-sequel', '~> 2.0', '>= 2.0.2'
  gem 'rack-test', '~> 2.1'
  gem 'rspec', '~> 3.12'
end
