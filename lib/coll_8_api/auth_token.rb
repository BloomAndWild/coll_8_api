# frozen_string_literal: true

module Coll8Api
  class AuthToken
    TOKEN_ENDPOINT = 'https://coll-8-dev.eu.auth0.com/oauth/token'
    AUDIENCE = 'https://api.drop2shop.ie'
    GRANT_TYPE = 'client_credentials'

    def token
      request_new_token['access_token']
    end

    private

    def request_new_token
      http_client = Faraday.new

      response = http_client.post(TOKEN_ENDPOINT) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = payload.to_json
      end

      body = JSON.parse(response.body)

      raise StandardError.new(payload: payload, body: body, status: response.status) unless response.success?

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

    def config
      Client.config
    end
  end
end
