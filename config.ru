#require_relative './config/environment'
#require 'rack/protection'

# Dir.glob('./app/{models,helpers}/*.rb').each { |file| require file }

# use Rack::Session::Pool
# set :protection, :session => true
# use Rack::Protection, permitted_origins: ["http://localhost:3000", "http://127.0.01:3000","https://www.lafindumois.app","https://lafindumois.app www.lafindumois.app lafindumois.app"], :except => :session_hijacking
#Rackup::Handler.default.run(LafindumoisBlog::API, :Port => 2300)

require_relative './config/config'
require 'rack/unreloader'

Unreloader = Rack::Unreloader.new(:subclasses=>%w'LafindumoisBlog'){LafindumoisBlog::API}
Unreloader.require './app/main.rb'

run Unreloader