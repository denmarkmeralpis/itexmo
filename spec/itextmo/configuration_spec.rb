require_relative '../spec_helper'

RSpec.describe Itexmo::Configuration do
  before do
    Itexmo.configure do |config|
      config.api_code = ENV['ITEXMO_API_CODE']
    end
  end

  context 'with configuration block' do
    it 'returns the correct itexmo api code' do
      expect(Itexmo.configuration.api_code).to eq(ENV['ITEXMO_API_CODE'])
    end
  end

  context 'without configuration block' do
    before do
      Itexmo.reset
    end

    it 'raises a configuration error for api_code' do
      expect { Itexmo.configuration.api_code }.to raise_error(Itexmo::Errors::Configuration)
    end
  end

  context '#reset' do
    it 'resets configured values' do
      expect(Itexmo.configuration.api_code).to eq(ENV['ITEXMO_API_CODE'])

      Itexmo.reset
      expect { Itexmo.configuration.api_code }.to raise_error(Itexmo::Errors::Configuration)
    end
  end
end
