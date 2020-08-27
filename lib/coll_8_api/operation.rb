# frozen_string_literal: true

module Coll8Api
  class Operation

    DEFAULT_HEADERS = {
      content_type: 'application/json'
    }.freeze

    def initialize(**options)
      @options = options
    end

    def execute
      http_client = Faraday.new
      http_client.authorization(:Bearer, token)

      response = http_client.run_request(http_method, endpoint, json_payload, headers)

      if response.success?
        body = JSON.parse(response.body, symbolize_names: true)
        return handle_response_body(body)
      end

      raise Coll8Api::Errors::ResponseError.new(payload: payload, body: response.body, status: response.status)
    end

    protected

    def http_method
      options[:http_method]
    end

    def service
      raise AbstractMethodError
    end

    def handle_response_body(body)
      body
    end

    private

    attr_reader :options

    def endpoint
      "#{base_url}/#{service}"
    end

    def json_payload
      JSON.generate(payload)
    end

    def headers
      DEFAULT_HEADERS.merge(options.fetch(:headers, {}))
    end

    def payload
      options[:payload]
    end

    def token
      options[:token]
    end

    def base_url
      config.base_url
    end

    def config
      Client.config
    end
  end
end
