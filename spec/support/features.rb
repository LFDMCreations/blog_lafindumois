# frozen_string_literal: true

RSpec.shared_context 'Reset class' do
  after do
    Object.send(:remove_const, :API)
  end
end
