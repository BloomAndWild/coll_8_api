# frozen_string_literal: true


RSpec.describe Coll8Api::Operations::TrackDelivery do
  before { configure_client }

  describe '#execute' do
    let(:subject) { described_class.new(tracking_number: tracking_number, token: ENV['COLL_8_TOKEN']) }

    context 'with a valid tracking number' do
      let(:tracking_number) { "BLWU110000000082" }
      let(:expected_response) do
        {
          "data": [
            {
              "eventCode": "DAT",
              "packageTrackingNumber": "BLWU110000000082001",
              "eventDateTime": "2020-09-01T11:31:08.067",
              "description": "Package Created"
            }
          ]
        }
      end

      it 'returns the tracking response' do
        VCR.use_cassette('coll_8_api/operations/tracking_response') do
          expect(subject.execute).to match(expected_response)
        end
      end
    end

    context 'with an invalid tracking number' do
      let(:tracking_number) { "INVALID_TRACKING_NUMBER" }
      let(:expected_response) do
        {
          "data": []
        }
      end

      it 'returns no data' do
        VCR.use_cassette('coll_8_api/operations/tracking_response_error') do
          expect(subject.execute).to match(expected_response)
        end
      end
    end
  end
end
