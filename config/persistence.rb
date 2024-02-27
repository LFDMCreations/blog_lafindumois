# frozen_string_literal: true

require 'yaml'
require 'sequel'
require 'bundler/setup'

APP_ENV = ENV['RACK_ENV'] || 'development'
ENV['SINATRA_ENV'] ||= 'development'
Bundler.require(ENV.fetch('SINATRA_ENV', nil))

def root
  __dir__
end

DB = if APP_ENV == 'development' || APP_ENV == 'test'
       Sequel.connect(YAML.load_file(File.join(root, 'database.yml'))[APP_ENV])
     else
       ## at Scalingo. To be replaced if you use another PaaS.
       Sequel.connect(ENV.fetch('SCALINGO_POSTGRESQL_URL', nil))
     end

DB.extension(:connection_validator)
DB.pool.connection_validation_timeout = -1
