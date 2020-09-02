# frozen_string_literal: true


RSpec.describe Coll8Api::Operations::CancelShipment do
  before { configure_client }

  describe '#execute' do
    let(:subject) { described_class.new(tracking_number: tracking_number, token: ENV['COLL_8_TOKEN']) }

    context 'with valid tracking number' do
      let(:tracking_number) { "BLWU110000000074" }
      let(:expected_response) { {:message =>"Shipment cancelled"} }

      it 'returns expected response' do
        VCR.use_cassette('coll_8_api/operations/cancel_shipment') do
          result = subject.execute

          expect(result).to eq(expected_response)
        end
      end
    end

    context 'with invalid tracking number' do
      let(:tracking_number) { "invalid_tracking_number" }
      let(:error_response) { {:message =>"Shipment not found"}.to_json }

      it 'raises an error' do
        VCR.use_cassette('coll_8_api/operations/cancel_shipment_invalid') do
          expect { subject.execute }.to raise_error(Coll8Api::Errors::ResponseError) do |err|
            expect(err.status).to eq(404)
            expect(err.message).to eq(error_response)
          end
        end
      end
    end
  end
end
