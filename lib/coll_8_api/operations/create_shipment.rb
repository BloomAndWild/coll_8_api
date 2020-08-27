# frozen_string_literal: true

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
