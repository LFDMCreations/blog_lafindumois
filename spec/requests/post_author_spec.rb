require 'rack/test'
require 'json'
require_relative '../../app/main.rb'

module LafindumoisBlog

    class API
        RSpec.describe 'An author creates an account', type: :request do

            def post_author(author)
                post '/authors/new', JSON.generate(author), 'CONTENT_TYPE' => 'application/json'
                # expect(last_response.status).to eq(200)
                # parsed = JSON.parse(last_response.body)
                # expect(parsed).to include('expense_id' => a_kind_of(Integer))
                # expense.merge('id' => parsed['expense_id'])
            end

            context 'and succeeds' do
                
                before do
                    post_author(
                        'name' => 'Fleurette', 'first_name' => 'Jean', 'slug' => 'Jean_de_Fleurette', 'email' => 'jdf@mail.fr'
                    )
                end

                it 'returns the author id' do
                    expect(last_response.body).to eq("ok")
                end

                it 'returns a 200 status' do
                    expect(last_response.status).to eq(200)
                end
            end

            context 'but fails' do

                before do
                    post_author(
                        'name' => nil, 'first_name' => nil, 'slug' => 'Jean_de_Fleurette', 'email' => 'jdf@mail.fr'
                    )
                end

                it 'returns an error message' do
                    expect(last_response.body).to eq("something went wrong")
                end

                it 'returns a 404 status' do
                    expect(last_response.status).to eq(404)
                end
            end
        end

    end


end

