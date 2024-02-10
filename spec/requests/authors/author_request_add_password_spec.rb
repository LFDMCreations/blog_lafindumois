require 'rack/test'
require 'json'
require_relative '../../../app/main.rb'

RSpec.describe 'Add a password to the user', type: :request do

    let(:author) { Author.create({'name' => 'Fleurette', 'first_name' => 'Jean', 'slug' => 'Jean_de_Fleurette', 'email' => 'jdf@mail.fr' }) }

    context 'successfully' do
    end

    context 'but fails' do
    end

end