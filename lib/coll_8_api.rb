# frozen_string_literal: true

require 'json'
require 'faraday'

require 'coll_8_api/errors/abstract_method_error'
require 'coll_8_api/errors/response_error'

require 'coll_8_api/config'
require 'coll_8_api/client'
require 'coll_8_api/auth_token'
require 'coll_8_api/version'

require 'coll_8_api/operation'
require 'coll_8_api/operations/create_shipment'
require 'coll_8_api/operations/cancel_shipment'
require 'coll_8_api/operations/track_delivery'

module Coll8Api
end
