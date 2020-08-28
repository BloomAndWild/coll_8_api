# frozen_string_literal: true

RSpec.describe Coll8Api::AuthToken do
  describe '#token' do
    context 'valid credentials' do
      before { configure_client }

      it 'retrieves a token' do
        VCR.use_cassette('coll_8_api/request_auth_token') do
          expect(described_class.new.token).to be_truthy
        end
      end
    end

    context 'invalid credentials' do
      before { configure_client(client_id: "bad", client_secret: "creds") }

      it 'raises an unauthorized exception' do
        VCR.use_cassette('coll_8_api/invalid_request_auth_token') do
          expect { described_class.new.token }.to raise_error(Coll8Api::Errors::ResponseError) do |err|
            expect(err.status).to eq(401)
          end
        end
      end
    end
  end
end
