# frozen_string_literal: true

require 'rack/test'
require 'json'
require_relative '../../app/main'

# module LafindumoisBlog
RSpec.describe 'Lafindumois blog api' do
  #     include_context 'Reset class'
  it 'says hi!' do
    get '/'
    expect(last_response).to be_successful
    # expect(last_response.body).to eq('bonjour Lafindumois')
  end
end
# end
