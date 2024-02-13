require 'rack/test'
require_relative '../../../app/models/author.rb'

RSpec.describe '#add_password' do

    let(:author) { Author.create({
        'name' => 'Fleurette', 
        'first_name' => 'Jean', 
        'slug' => 'Jean_de_Fleurette', 
        'email' => 'jdf@mail.fr' 
    })}

    context 'successfully' do
        it 'returns true' do
            expect(author.add_password(author)).to be_truthy
        end
    end

    context 'but fails' do
    end

end
