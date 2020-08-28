# frozen_string_literal: true

RSpec.describe Coll8Api::Operations::CreateShipment do
  before { configure_client }

  describe '#execute' do
    let(:payload) do
      {
        "account": {
          "accountCode": ENV['COLL_8_ACCOUNT']
        },
        "serviceType": "drop2shop-Return",
        "goodsDescription": "Sample Return",
        "shippingDate": "2020-06-30",
        "numberOfPackages": 1,
        "pudoCode": "TEST0001",
        "references": [{
          "referenceType": "customerReference",
          "referenceValue": "SH-RET RMA: 1000001"
        }
        ],
        "packages": [{
          "packagingType": "Box",
          "shipperTrackingNumber": "RET: 1001/0088"
        }],
        "signatureServices": [{
          "service": "QRConfirmation"
        }],
        "addresses": [{
          "addressLine1": "Consignee Close",
          "city": "Raheny",
          "postCode": "D05",
          "state": "Dublin",
          "country": "Ireland",
          "addressType": "shipFrom",
          "contact": {
            "contactName": "consignee name",
            "email": "consignee@receiver.com",
            "mobileNumber": "+353870000000"
          }
        }, {
          "addressLine1": "Shippers Return Plaza",
          "city": "London",
          "postCode": "EC2R",
          "countryCode": "GBR",
          "country": "Great Britian",
          "addressType": "shipTo",
          "addressLocationType": "business",
          "contact": {
            "contactName": "shipper return contact",
            "email": "shipper-returns@business.com",
            "mobileNumber": "+4470000000"
          }
        }]
      }
    end

    let(:subject) { described_class.new(payload: payload) }

    context 'with invalid account number' do
      let(:account) { Coll8Api::Client.config.account }

      it 'returns error response body' do
        VCR.use_cassette('create_shipment/invalid_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              {
                "isSuccess": false,
                "errors": [
                  {
                    "property": "Account.AccountCode",
                    "message": "Account does not exist in system"
                  },
                  {
                    "property": "ServiceType",
                    "message": "Unknown Service Type"
                  },
                  {
                    "property": "Addresses[1].City",
                    "message": "'City' must not be empty."
                  }
                ]
              }
            )
          )
        end
      end
    end

    context 'with valid account number' do
      let(:account) { Coll8Api::Client.config.account }

      it 'returns response body' do
        VCR.use_cassette('shipment_request/valid_request') do
          result = subject.execute

          expect(result).to match(
            hash_including(
              {
                "isSuccess": true,
                "trackingNumber": "DEVU110000000611",
                "packageTrackingNumbers": [
                  "DEVU110000000611001"
                ]
              }
            )
          )
        end
      end
    end
  end
end
