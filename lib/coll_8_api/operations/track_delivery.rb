# frozen_string_literal: true
#
# POST {{ base_url }}/tracking/{trackingNumber}/scan
#
module Coll8Api
  module Operations
    class TrackDelivery < Operation
      SERVICE_NAME = 'tracking'

      private

      def service
        SERVICE_NAME
      end

      def http_method
        :get
      end

      def endpoint
        "#{base_url}/#{service}/#{tracking_number}/scan"
      end

      def tracking_number
        options[:tracking_number]
      end
    end
  end
end
