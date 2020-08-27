# frozen_string_literal: true
#
# POST {{ base_url }}api/shipment/{trackingNumber}/cancel
#
module Coll8Api
  module Operations
    class CancelShipment < Operation
      SERVICE_NAME = 'shipment'

      private

      def service
        SERVICE_NAME
      end

      def endpoint
        "#{base_url}/#{service}/#{tracking_number}/cancel"
      end

      def tracking_number
        options[:tracking_number]
      end
    end
  end
end
