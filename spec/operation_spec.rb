# frozen_string_literal: true

RSpec.describe Coll8Api::Operation do
  before do
    configure_client
  end

  describe 'bad requests' do
    let(:default_op_class) do
      Class.new(described_class) do
        def service
          'shipment'
        end
      end
    end

    context 'with invalid token' do
      let(:options) do
        {
          token: 'Some-nonsense',
          http_method: :post,
          payload: {}
        }
      end

      it 'raises an exception' do
        VCR.use_cassette('coll_8_api/operations/invalid_token') do
          expect { default_op_class.new(**options).execute }.to raise_error(Coll8Api::Errors::ResponseError) do |err|
            expect(err.status).to eq(401)
          end
        end
      end
    end
  end
end
