# frozen_string_literal: true
#
# POST {{ base_url }}/api/shipment/
#
module Coll8Api
  module Operations
    class CreateShipment < Operation
      SERVICE_NAME = 'shipment'

      private

      def service
        SERVICE_NAME
      end
    end
  end
end
