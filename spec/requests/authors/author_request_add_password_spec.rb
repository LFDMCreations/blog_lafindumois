# frozen_string_literal: true

require 'rack/test'
require 'json'
require_relative '../../../app/main'

RSpec.describe 'Create a password for an author', type: :request do
  def create_author(slug, email)
    Author.create({ 'name' => 'Fleurette', 'first_name' => 'Jean', 'slug' => slug, 'email' => email })
  end

  context 'with a valid password and' do
    it 'succeeds' do
      data = {
        author: create_author('jean', 'jean@maila.fr').id,
        password: 'Fse234dsPL!Eh55_'
      }

      post '/authors/password/add', data.to_json, { 'HTTP_ACCEPT' => 'app/json', 'CONTENT_TYPE' => 'app/json' }
      expect(last_response.status).to eq(200)
    end
  end

  context 'with an invalid password and' do
    it 'fails' do
      data = {
        author: create_author('johnny', 'jean@maila.com').id,
        password: nil
      }
      post '/authors/password/add', data.to_json, { 'HTTP_ACCEPT' => 'app/json', 'CONTENT_TYPE' => 'app/json' }
      expect(last_response.body).to eq('bonjour')
    end
  end
end
