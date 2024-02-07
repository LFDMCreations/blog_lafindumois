require 'rack/test'
require 'json'
require_relative '../../../app/main.rb'

module LafindumoisBlog
    class API
        RSpec.describe 'An author creates an account', type: :request do
            
            let(:request_headers) do
                {"HTTP_ACCEPT" => "app/json", "CONTENT_TYPE" => "app/json"}
            end

            context 'and succeeds' do
                let(:auteur) {{'name' => 'Fleurette', 'first_name' => 'Jean', 'slug' => 'Jean_de_Fleurette', 'email' => 'jdf@mail.fr' }}
                it 'returns the author id' do
                    post '/authors/signup', auteur.to_json, request_headers
                    expect(last_response.status).to eq(200)
                    parsed = JSON.parse(last_response.body)
                    expect(parsed).to include('author' => a_kind_of(Integer))
                end
            end

            context 'but fails' do
                let(:auteur) {{  'name' => nil, 'first_name' => nil, 'slug' => 'Jeanno_de_Fleurette', 'email' => 'jrdf@mail.fr' }}
                it 'returns an error message' do
                    post '/authors/signup', auteur.to_json, request_headers
                    expect(last_response.status).to eq(402)
                    parsed = JSON.parse(last_response.body)
                    expect(parsed).to include('message' => 'something went wrong')
                end
            end
        end
    end
end
