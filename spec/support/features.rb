RSpec.shared_context 'Reset class' do

    after(:each) do
        Object.send(:remove_const, :API)
    end

end