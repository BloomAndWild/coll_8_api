# frozen_string_literal: true

RSpec.describe Coll8Api::Config do
  it { is_expected.to respond_to(:base_url, :base_url=) }
  it { is_expected.to respond_to(:client_id, :client_id=) }
  it { is_expected.to respond_to(:client_secret, :client_secret=) }
  it { is_expected.to respond_to(:account, :account=) }
  it { is_expected.to respond_to(:logger, :logger=) }
end
