# frozen_string_literal: true

module Coll8Api
  class AuthToken
    AUDIENCE = 'https://api.drop2shop.ie'
    GRANT_TYPE = 'client_credentials'

    def token
      request_new_token['access_token']
    end

    private

    def request_new_token
      http_client = Faraday.new

      response = http_client.post(token_endpoint) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = payload.to_json
      end

      body = JSON.parse(response.body)

      unless response.success?
        raise Coll8Api::Errors::ResponseError.new(payload: payload, body: body, status: response.status)
      end

      body
    end

    def payload
      {
        "client_id": config.client_id,
        "client_secret": config.client_secret,
        "audience": AUDIENCE,
        "grant_type": GRANT_TYPE
      }
    end

    def token_endpoint
      config.token_endpoint
    end

    def config
      Client.config
    end
  end
end
