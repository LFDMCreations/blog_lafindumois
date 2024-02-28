# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'sequel'
require_relative 'helpers/applicationhelpers'
require_relative 'models/author'
# Dir['/models'].each { |file| require file }

# Main module for the bloc application
module LafindumoisBlog
  # main class API that inherits from Sinatra::Base
  class API < Sinatra::Base

    register Sinatra::Namespace

    configure do
      set :server, %w[puma]
     # set :default_content_type, 'application/json'
    end

    get '/' do
      status 200
    end

    namespace '/authors' do

      post '/signup' do
        auteur = JSON.parse request.body.read
        begin
          saved_author = Author.create(auteur.deep_symbolize_keys)
          status 200
          json author: saved_author[:id]
        rescue StandardError
          status 402
          json message: 'something went wrong'
        end
      end

      post '/login' do
        status 200
      end

      namespace '/password' do


        post '/add' do

          data = JSON.parse request.body.read
          data = data.deep_symbolize_keys
          author = Author[data[:author]]
          if author.add_password(author, data[:password])
            status 200
            json message: "success"
          else
             status 402
            json error: "invalid password"
          end
        end

      end
    end

    namespace '/articles' do
      
      get '/' do
        status 200
      end

    end
  end
end
