require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'sequel'
require_relative './helpers/applicationhelpers'
require_relative './models/author.rb'
#Dir['/models'].each { |file| require file }


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

            post '/signup' do
                auteur = JSON.parse request.body.read
                begin
                    saved_author = Author.create(auteur.deep_symbolize_keys)
                    status 200
                    json :author => saved_author[:id]
                rescue => exception
                    status 402
                    json :message => "something went wrong"
                end
            end

            post '/login' do
            end

        end

        
    end
end