# frozen_string_literal: true

module Coll8Api
  module Errors
    class ResponseError < StandardError
      attr_reader :payload, :status, :body

      def initialize(payload:, status:, body:)
        @payload = payload
        @status = status
        @body = body

        super(build_message)
      end

      private

      def build_message
        return status unless body.is_a?(String)

        json = JSON.parse(body)
        json["message"] || json["errors"].to_json
      rescue JSON::ParserError
        body
      end
    end
  end
end
