# frozen_string_literal: true
#
# POST {{ base_url }}/shipment
#
module Coll8Api
  module Operations
    class CreateShipment < Operation
      private

      def endpoint
        "#{base_url}/shipment"
      end
    end
  end
end
