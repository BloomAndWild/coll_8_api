# frozen_string_literal: true
#
# GET {{ base_url }}/label
#
module Coll8Api
  module Operations
    class GetLabel < Operation
      private

      def http_method
        :get
      end

      def endpoint
        "#{base_url}/label?labelType=#{label_type}&trackingNumber=#{tracking_number}"
      end

      def tracking_number
        options[:tracking_number]
      end

      def label_type
        options[:label_type] || :pdf
      end
    end
  end
end
