# frozen_string_literal: true

require 'logger'

def configure_client(base_url: nil, client_id: nil, client_secret: nil, account: nil)
  Coll8Api::Client.configure do |config|
    config.base_url = base_url || ENV.fetch('COLL_8_BASE_URL')
    config.client_id = client_id || ENV.fetch('COLL_8_CLIENT_ID')
    config.client_secret = client_secret || ENV.fetch('COLL_8_CLIENT_SECRET')
    config.account = account || ENV.fetch('COLL_8_ACCOUNT')

    logger = Logger.new(STDERR)
    logger.level = :debug
    config.logger = logger
  end
end
