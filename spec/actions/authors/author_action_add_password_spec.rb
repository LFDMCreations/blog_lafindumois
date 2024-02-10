require 'rack/test'
require_relative '../../../app/models/author.rb'

RSpec.describe Author do
    let(:auteur) { Author.new }
    context 'tout va bien' do
        it 'says all is good' do
            expect(auteur.essaie('oui')).to eq('ça va')
        end
    end
    context 'il y a souci en la demeure' do
        it 'says there is a problem' do
            expect(auteur.essaie('non')).to eq('aie')
        end
    end
end
