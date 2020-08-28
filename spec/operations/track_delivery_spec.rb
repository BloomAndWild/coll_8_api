# frozen_string_literal: true


RSpec.describe Coll8Api::Operations::TrackDelivery do
  before { configure_client }

  describe '#execute' do


    let(:options) do
      {
        tracking_number: tracking_number,
        token: "No authentication needed?"
      }
    end

    let(:expected_response) do
      {
        "data": [
          {
            "eventCode": "DAT",
            "packageTrackingNumber": "TEST110000000074001",
            "eventDateTime": "2020-05-25T08:32:04.843",
            "description": "Package Created"
          },
          {
            "eventCode": "DAT",
            "packageTrackingNumber": "TEST110000000074002",
            "eventDateTime": "2020-05-25T08:32:04.843",
            "description": "Package Created"
          },
          {
            "eventCode": "dip",
            "packageTrackingNumber": "TEST110000000074001",
            "eventDateTime": "2020-05-25T08:32:56.77",
            "description": "Depot Inbound"
          }
        ]
      }
    end

    let(:subject) { described_class.new(options) }

    context 'with a valid tracking number' do
      let(:tracking_number) { "TEST110000000074" }

      it 'returns the tracking response' do
        VCR.use_cassette('tracked_delivery/tracking_response') do
          result = subject.execute

          expect(result).to match(expected_response)
        end
      end
    end

    context 'with an invalid tracking number' do
      let(:tracking_number) { "INVALID_TRACKING_NUMBER" }

      it 'returns no data' do
        VCR.use_cassette('tracked_delivery/tracking_invalid_response') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              {
                "data": []
              }
            )
          )
        end
      end
    end
  end
end
