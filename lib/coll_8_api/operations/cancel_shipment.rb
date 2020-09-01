# frozen_string_literal: true
#
# POST {{ base_url }}/api/shipment/{trackingNumber}/cancel
#
module Coll8Api
  module Operations
    class CancelShipment < Operation
      private

      def endpoint
        "#{base_url}/shipment/#{tracking_number}/cancel"
      end

      def tracking_number
        options[:tracking_number]
      end
    end
  end
end
