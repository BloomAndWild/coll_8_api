# frozen_string_literal: true

RSpec.describe Coll8Api::Operations::GetLabel do
  before { configure_client }

  describe '#execute' do
    let(:label_type) { nil }
    let(:subject) { described_class.new(tracking_number: tracking_number, token: ENV['COLL_8_TOKEN'], label_type: label_type) }

    context 'with a valid tracking number' do
      around do |spec|
        VCR.use_cassette('coll_8_api/operations/get_label_response') do
          spec.run
        end
      end

      let(:tracking_number) { "BLWU110000000694" }
      let(:expected_response) do
        {
          "data": {
            "pdf": [
              a_kind_of(String),
            ],
          }
        }
      end

      it 'returns the base64 encoded PDF' do
        expect(subject.execute).to match(expected_response)
      end

      context "when requesting a PNG label" do
        let(:label_type) { :png }
        let(:expected_response) do
          {
            "data": {
              "png": [
                a_kind_of(String),
              ],
            }
          }
        end

        it 'returns the base64 encoded PNG' do
          expect(subject.execute).to match(expected_response)
        end
      end

      context "when requesting a ZPL label" do
        let(:label_type) { :zpl }
        let(:expected_response) do
          {
            "data": {
              "zpl": [
                a_kind_of(String),
              ],
            }
          }
        end

        it 'returns the ZPL' do
          expect(subject.execute).to match(expected_response)
        end
      end
    end

    context 'with an invalid tracking number' do
      let(:tracking_number) { "INVALID_TRACKING_NUMBER" }

      it 'raises an error' do
        VCR.use_cassette('coll_8_api/operations/get_label_response_error') do
          expect{subject.execute}.to raise_error(Coll8Api::Errors::ResponseError, "Could not find label for shipment")
        end
      end
    end
  end
end
