# frozen_string_literal: true

RSpec.describe Coll8Api::Client do
  describe '.configure' do
    it 'raises an exception without a block' do
      expect { described_class.configure }.to raise_error(ArgumentError, 'block not given')
    end

    it 'provides a config object in the block' do
      described_class.configure do |config|
        expect(config).to be_instance_of(Coll8Api::Config)
      end
    end
  end
end
