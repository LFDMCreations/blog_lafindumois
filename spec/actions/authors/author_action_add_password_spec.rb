# frozen_string_literal: true

require 'rack/test'
require_relative '../../../app/models/author'

RSpec.describe Author do
  def create_author(slug, email)
    Author.create({
                    'name' => 'Fleurette',
                    'first_name' => 'Jean',
                    'slug' => slug,
                    'email' => email
                  })
  end

  context 'when a password is provided' do
    example 'that is valid' do
      author = create_author('unauteur', 'unauteur@moi.fr')
      expect(author.add_password(author, 'fqsFF(3jjD!)')).to be_a AuthorPassword
    end

    example 'that is unvalid' do
      author = create_author('deuxauteur', 'deuxauteur@moi.fr')
      expect(author.add_password(author, 'fqsFFsfghdfjj')).to be_falsy
    end
  end
  #
  #     context 'password creation fails' do
  #         expect(author.add_password(author, 'qlsgkqdsgGF')).to be_falsy
  #     end
end
