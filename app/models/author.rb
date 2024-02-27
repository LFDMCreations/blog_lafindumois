# frozen_string_literal: true

require 'bcrypt'

# Set all methods relatdd to Aithors of articles
class Author < Sequel::Model

  one_to_one :authorPassword


  def add_password(author, password)
    return false if password_validator(password) == false
    begin
      author.authorPassword = AuthorPassword.new(password_digest: BCrypt::Password.create(password))
      return true
    rescue => exception
      exception
    end
  end

  private

  def password_validator(password)
    matcher = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/
    return false if matcher.match(password).nil?
    true
  end
end

# put authors' passowrds in a seperat table
class AuthorPassword < Sequel::Model(:author_password_hashes)
  one_to_one :author
end
