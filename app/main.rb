require 'sinatra/base'
require_relative './helpers/applicationhelpers'

module LafindumoisBlog    
    class API < Sinatra::Base

        helpers ApplicationHelpers

        configure do
            set :server, %w[puma]
            set :port, 9494
            set :default_content_type, 'application/json'
        end

        get '/' do
            retour = "bonjour Lafindumois"
            json_status(200, retour)
            #status 201
        end

        
    end
end