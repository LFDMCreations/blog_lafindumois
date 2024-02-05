require 'rack/test'
require 'json'
require_relative '../../app/main.rb'

module LafindumoisBlog
    RSpec.describe 'Lafindumois blog api', type: :request do
        it 'says hi!' do
            get '/'
            expect(last_response.status).to eq(200)
            expect(last_response).to be_successful
            #expect(last_response.body).to eq('bonjour Lafindumois')
        end
    end
end