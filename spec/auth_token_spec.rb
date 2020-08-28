# frozen_string_literal: true

RSpec.describe Coll8Api::AuthToken do
  before { configure_client }

  describe '#token' do
    it 'retrieves a token' do
      VCR.use_cassette('coll_8_api/request_auth_token') do
        expect(described_class.new.token).to be_truthy
      end
    end
  end
end
