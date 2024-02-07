require 'rack/test'
require 'json'
require_relative '../../../app/main.rb'

module LafindumoisBlog
  #  class API
        RSpec.describe 'An author logs in to his account', type: :request do

            let(:request_headers) do
                {"HTTP_ACCEPT" => "app/json", "CONTENT_TYPE" => "app/json"}
            end

            context 'successfully' do

                let(:auteur) {{ 'email' => 'jdeflorette@mail.fr', 'password' => 'manon' }}
=begin
                it 'gives green light' do
                    pending('path not implemented yet')
                    fail
#                    post '/authors/login', auteur.to_json, request_headers
                end
=end
            end




        end
   # end
end
