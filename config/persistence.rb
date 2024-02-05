require 'yaml'
require 'sequel'
require 'bundler/setup'

APP_ENV = ENV["RACK_ENV"] || "development"
ENV['SINATRA_ENV'] ||= "development"
Bundler.require(ENV['SINATRA_ENV'])

def root
    File.expand_path(File.dirname(__FILE__))
end

if APP_ENV == "development" || APP_ENV == "test"
    DB = Sequel.connect(YAML.load_file(File.join(root,'database.yml'))[APP_ENV])
else
    ## at Scalingo. To be replaced if you use another PaaS.
    DB = Sequel.connect(ENV['SCALINGO_POSTGRESQL_URL'])
end
  
 DB.extension(:connection_validator)
 DB.pool.connection_validation_timeout = -1
