# frozen_string_literal: true

require 'logger'

def configure_client(base_url: nil, username: nil, password: nil)
  if ENV["COLL_8_CLIENT_ID"].nil? && ENV["COLL_8_CLIENT_SECRET"].nil?
    fail "COLL_8_CLIENT_ID and COLL_8_CLIENT_SECRET environment variables not set"
  end

  Coll8Api::Client.configure do |config|
    config.base_url = ENV["COLL_8_BASE_URL"]
    config.client_id = ENV["COLL_8_CLIENT_ID"]
    config.client_secret = ENV["COLL_8_CLIENT_SECRET"]
    config.account = ENV["COLL_8_ACCOUNT"]

    config.logger = Logger.new(STDERR)
  end
end
