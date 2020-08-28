# frozen_string_literal: true


RSpec.describe Coll8Api::Operations::CancelShipment do
  before { configure_client }

  describe '#execute' do
    let(:options) do
      {
        tracking_number: tracking_number,
        token: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik1UazNPREF6TkRRelJqUXpOamRFTkVaQk9UazRORFJCTnpVeU56RkRSVUkwTTBJMk56STJSZyJ9.eyJpc3MiOiJodHRwczovL2NvbGwtOC1kZXYuZXUuYXV0aDAuY29tLyIsInN1YiI6InhSczJUNXptczJtM1JSQ1RwaHZJSEs0VDFkYmR5QW5aQGNsaWVudHMiLCJhdWQiOiJodHRwczovL2FwaS5kcm9wMnNob3AuaWUiLCJpYXQiOjE1OTg1MjgyNTMsImV4cCI6MTU5ODYxNDY1MywiYXpwIjoieFJzMlQ1em1zMm0zUlJDVHBodklISzRUMWRiZHlBbloiLCJndHkiOiJjbGllbnQtY3JlZGVudGlhbHMiLCJwZXJtaXNzaW9ucyI6W119.UZi9J5QOYNR09dKfW6B2IHHigqQmlcK89V_coxddIoL3iFnNweh0NUFejcxK-v0LU4mTWmkbyYMF0vCH6V8PhH6gu4MGsmJQuCIKFeNPrZo5WS3NTBeApj_ZkRTg6kNXcVqFEt3p5Kp8obsfrUBTrHD2ryd1iWrWSu1nMkpvBp3GlqUzYvmus5ovaZFztqoNtxXpRHLe7Fdgg-7HDo6TDh7oRaoRT_bBidBpJPMcLIPmN6hxMukkIHyVdMFS_icJpziRh8TdoKN7sPSn-Wms9KlTJvd0J3DM7GfX3iz7f_Ru49Tf0ThV3Z-x2Lq52Uszf9z-JS7HTK9Z2JNnW0zl8w"
      }
    end

    let(:subject) { described_class.new(options) }

    context 'with real tracking number' do
      let(:tracking_number) { "get_a_real_one" }
      let(:expected_response) { "not sure may be nothing or the updated shipment with Status: 'cancelled'" }

      it 'returns expected response' do
        VCR.use_cassette('cancel_shipment/valid_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(expected_response))
        end
      end
    end

    context 'with invalid tracking number' do
      let(:tracking_number) { "invalid_tracking_number" }

      it 'raises an error' do
        VCR.use_cassette('cancel_shipment/invalid_request') do
          expect { subject.execute }.to raise_error(Coll8Api::Errors::ResponseError) do |err|
            expect(err.status).to eq(404)
          end
        end
      end
    end
  end
end
