# frozen_string_literal: true

RSpec.describe Coll8Api::Operations::CreateShipment do
  before { configure_client }

  describe '#execute' do
    let(:payload) do
      {
        "account": {
          "accountCode": ENV['COLL_8_ACCOUNT']
        },
        "serviceType": "drop2me",
        "goodsDescription": "Sample Signature Required",
        "shippingDate": "2020-09-03",
        "numberOfPackages": 1,
        "references": [
          {
            "referenceType": "customerReference",
            "referenceValue": "SH-Me 0107-001"
          }
        ],
        "packages": [
          {
            "packagingType": "Box",
            "weight": 1
          }
        ],
        "signatureServices": [
          {
            "service": "SignatureRequired"
          }
        ],
        "addresses": [
          {
            "addressLine1": "Shippers Lane",
            "city": "London",
            "postCode": "EC2R",
            "countryCode": "GBR",
            "country": "Great Britain",
            "addressType": "shipFrom",
            "addressLocationType": "business",
            "contact": {
              "contactName": "shipper contact",
              "email": "shipper@business.com",
              "mobileNumber": "+4470000000"
            }
          },
          {
            "addressLine1": "Merrion St Upper",
            "city": "Dublin 2",
            "postCode": "D02 R583",
            "state": "Dublin",
            "country": "Ireland",
            "addressType": "shipTo",
            "contact": {
              "contactName": "consignee name",
              "email": "consignee@receiver.com",
              "mobileNumber": "+353870000000"
            }
          }
        ]
      }
    end

    let(:subject) { described_class.new(payload: payload, token: ENV['COLL_8_TOKEN']) }

    context 'with valid request' do
      let(:expected_response) do
        {
          "trackingNumber": "BLWU110000000041",
          "packageTrackingNumbers": [
            "BLWU110000000041001"
          ]
        }
      end
      it 'returns response body' do
        VCR.use_cassette('coll_8_api/operations/create_shipment') do
          expect(subject.execute).to eq(expected_response)
        end
      end
    end

    context 'errors' do
      context 'with an invalid account code' do
        let(:error_response) do
          "You are Unauthorized to Create/Update Shipments for this Shipping Account"
        end

        before do
          payload[:account][:accountCode] = "Blah"
        end

        it 'raises an error' do
          VCR.use_cassette('coll_8_api/operations/invalid_account_error') do
            expect { subject.execute }.to raise_error(Coll8Api::Errors::ResponseError) do |err|
              expect(err.status).to eq(403)
              expect(err.message).to eq(error_response)
            end
          end
        end
      end

      context 'without a package weight' do
        let(:error_response) do
          [{ "property": "Packages[0].Weight", "message": "Weight should be greater than 0 kg" }].to_json
        end

        before do
          payload[:packages] = [
            {
              "packagingType": "Box"
            }
          ]
        end

        it 'raises an error' do
          VCR.use_cassette('coll_8_api/operations/missing_package_weight_error') do
            expect { subject.execute }.to raise_error(Coll8Api::Errors::ResponseError, error_response)
          end
        end
      end

      context 'with an invalid recipient postcode' do
        let(:error_response) do
          [{ "message": "Recipient's Postcode is incorrect." }].to_json
        end

        before do
          payload[:addresses][1][:postcode] = "DB2"
        end

        it 'raises an error' do
          VCR.use_cassette('coll_8_api/operations/invalid_recipient_postcode_error') do
            expect { subject.execute }.to raise_error(Coll8Api::Errors::ResponseError, error_response)
          end
        end
      end
    end
  end
end
