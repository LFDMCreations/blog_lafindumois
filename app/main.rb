require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'sequel'

require_relative './helpers/applicationhelpers'
Dir['models'].each { |file| require file }


module LafindumoisBlog    
    class API < Sinatra::Base

        register Sinatra::Namespace
        helpers ApplicationHelpers

        configure do
            set :server, %w[puma]
           # set :port, 9494
         #   set :default_content_type, 'application/json'
        end

        get '/' do
            json "bonjour Lafindumois"
            status 200
        end


        namespace '/authors' do

            post '/new' do

                #curl -X POST http://localhost:9292/authors/new -H "Content-Type: application/json" -d'{"name":"Jean","first_name":"","slug":"oups","email":"jdf@mail.fr"}'
                
                auteur = JSON.parse request.body.read

                if auteur['first_name'] == "Jean"
                    status 200
                    "ok"
                else
                    status 404
                    "something went wrong"
                end

            end

        end

        
    end
end