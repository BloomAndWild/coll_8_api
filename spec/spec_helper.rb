# frozen_string_literal: true

require 'dotenv'
require 'vcr'

require 'bundler/setup'
require 'coll_8_api'

require_relative 'support/helpers/client_helper'

Dotenv.load

VCR.configure do |c|
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.cassette_library_dir = 'spec/support/fixtures/vcr_cassettes'
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = { match_requests_on: [:uri] }

  # Filter senstive test credentials from VCR interaction.
  c.filter_sensitive_data('<CLIENT_ID>') { ENV['COLL_8_CLIENT_ID'] }
  c.filter_sensitive_data('<CLIENT_SECRET>') { ENV['COLL_8_CLIENT_SECRET'] }
  c.filter_sensitive_data('<ACCOUNT_REF>') { ENV['COLL_8_ACCOUNT'] }
  c.filter_sensitive_data('<BEARER_TOKEN>') do |interaction|
    auths = interaction.request.headers['Authorization']&.first
    if (match = auths&.match(/^Bearer\s+([^,\s]+)/))
      match.captures.first
    end
  end
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
