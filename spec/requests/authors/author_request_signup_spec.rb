# frozen_string_literal: true

require 'rack/test'
require 'json'
require_relative '../../../app/main'

RSpec.describe 'An author creates an account', type: :request do
  def post_request(data)
    post '/authors/signup', data.to_json, { 'HTTP_ACCEPT' => 'app/json', 'CONTENT_TYPE' => 'app/json' }
    last_response
  end

  context 'with valid data' do
    it 'returns the author id' do
      post_request({ 'name' => 'Fleurette', 'first_name' => 'Jean', 'slug' => 'Jean_de_Fleurette',
                     'email' => 'jdf@mail.fr' })
      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('author' => a_kind_of(Integer))
    end
  end

  context 'with invalid data' do
    it 'returns an error message' do
      post_request({ 'name' => nil, 'first_name' => nil, 'slug' => 'Jeanno_de_Fleurette',
                     'email' => 'jrdf@mail.fr' })
      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('message' => 'something went wrong')
    end
  end
end
