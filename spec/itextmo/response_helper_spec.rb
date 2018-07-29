require_relative '../spec_helper'

RSpec.describe Itexmo::ResponseHelper do
  context '#parse' do
    it 'raises Authentication error' do
      expect { Itexmo::ResponseHelper.parse('INVALID') }.to raise_error(Itexmo::Errors::Authentication)
      expect { Itexmo::ResponseHelper.parse('INVALID_APICODE') }.to raise_error(Itexmo::Errors::Authentication)
      expect { Itexmo::ResponseHelper.parse('NOT_SUPPORTED') }.to raise_error(Itexmo::Errors::Authentication)
    end

    it 'returns json error' do
      expect(Itexmo::ResponseHelper.parse('ERROR')).to have_key(:code)
      expect(Itexmo::ResponseHelper.parse('SUCCESS')).to have_key(:code)
    end

    it 'returns empty array' do
      expect(Itexmo::ResponseHelper.parse('EMPTY')).to eq([])
    end

    it 'returns hash' do
      expect(Itexmo::ResponseHelper.parse('[{ "sample_hash": "sample_value_hash" }]')).not_to be_nil
    end
  end
end
