# frozen_string_literal: true

source "https://rubygems.org"

gem 'puma', '~> 6.4', '>= 6.4.2'
gem "sinatra", "~> 4.0"
gem 'sinatra-contrib', '~> 4.0'
gem "pg", "~> 1.5"
gem "sequel", "~> 5.77"

gem "rackup", "~> 2.1"

group :test, :development do
    gem 'rack-unreloader', '~> 2.1'
    gem 'racksh', '~> 1.0', '>= 1.0.1'
end

group :test do
    gem "rack-test", "~> 2.1"
    gem "rspec", "~> 3.12"
    gem 'database_cleaner-sequel', '~> 2.0', '>= 2.0.2'
end
