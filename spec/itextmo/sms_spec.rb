require_relative '../spec_helper'

RSpec.describe Itexmo::Sms do
  let(:client) { Itexmo::Sms }
  let(:uri) { 'https://www.itexmo.com/php_api' }
  let(:api_code) { ENV['ITEXMO_API_CODE'] }

  before do
    Itexmo.configure do |config|
      config.api_code = ENV['ITEXMO_API_CODE']
    end
  end

  context '#display_outgoing' do
    it 'returns success desc order' do
      stub_request(:get, uri + '/display_outgoing.php').with(query: { apicode: api_code, sortby: 'desc' }).to_return(body: 'EMPTY')
      expect(client.display_outgoing('desc')).to eq([])
    end

    it 'returns success without specifying sortby params' do
      stub_request(:get, uri + '/display_outgoing.php').with(query: { apicode: api_code, sortby: 'asc' }).to_return(body: 'EMPTY')
      expect(client.display_outgoing).to eq([])
    end

    it 'raises invalid parameter' do
      stub_request(:get, uri + '/display_outgoing.php').with(query: { apicode: api_code, sortby: 'invalid' }).to_return(body: 'INVALID PARAMETERS')
      expect { client.display_outgoing('invalid') }.to raise_error(Itexmo::Errors::BadRequest)
    end
  end

  context '#delete_all_outgoing' do
    it 'returns json success' do
      stub_request(:get, uri + '/delete_outgoing_all.php').with(query: { apicode: api_code }).to_return(body: 'SUCCESS')
      expect(client.delete_all_outgoing).to have_key(:code)
      expect(client.delete_all_outgoing[:code]).to eq(200)
    end
  end

  context '#display_messages' do
    it 'returns success but empty array' do
      stub_request(:get, uri + '/display_messages.php').with(query: { apicode: api_code }).to_return(body: 'EMPTY')
      expect(client.display_messages).to eq([])
    end

    it 'returns success with json array' do
      response = '[{"content": "content"}]'
      stub_request(:get, uri + '/display_messages.php').with(query: { apicode: api_code }).to_return(body: response)
      expect(client.display_messages.count).to eq(1)
    end
  end

  context '#display_messages_via_originator' do
    it 'returns json success but empty array' do
      stub_request(:get, uri + '/display_messages_via_originator.php').with(query: { apicode: api_code, originator: '09177710296' }).to_return(body: 'EMPTY')
      expect(client.display_messages_via_originator('09177710296')).to eq([])
    end

    it 'returns success with json array' do
      response = '[{"some_key": "some_value"}]'
      stub_request(:get, uri + '/display_messages_via_originator.php').with(query: { apicode: api_code, originator: '09177710296' }).to_return(body: response)
      expect(client.display_messages_via_originator('09177710296').count).to eq(1)
    end

    it 'raises Authentication error due to non corporate api code' do
      stub_request(:get, uri + '/display_messages_via_originator.php').with(query: { apicode: api_code, originator: '09177710296' }).to_return(body: 'NOT_SUPPORTED')
      expect { client.display_messages_via_originator('09177710296') }.to raise_error(Itexmo::Errors::Authentication)
    end
  end

  context '#delete_message_via_originator' do
    it 'returns json success' do
      stub_request(:get, uri + '/delete_message_via_originator.php').with(query: { apicode: api_code, originator: '09177710296' }).to_return(body: 'SUCCESS')
      expect(client.delete_message_via_originator('09177710296')).to have_key(:code)
      expect(client.delete_message_via_originator('09177710296')[:code]).to eq(200)
    end

    it 'returns json error' do
      stub_request(:get, uri + '/delete_message_via_originator.php').with(query: { apicode: api_code, originator: '09177710296' }).to_return(body: 'ERROR')
      expect(client.delete_message_via_originator('09177710296')).to have_key(:code)
      expect(client.delete_message_via_originator('09177710296')[:code]).to eq(422)
    end
  end

  context '#delete_message_via_id' do
    it 'returns json success' do
      stub_request(:get, uri + '/delete_message_via_id.php').with(query: { apicode: api_code, id: '102' }).to_return(body: 'SUCCESS')
      expect(client.delete_message_via_id('102')).to have_key(:code)
      expect(client.delete_message_via_id('102')[:code]).to eq(200)
    end

    it 'returns json error' do
      stub_request(:get, uri + '/delete_message_via_id.php').with(query: { apicode: api_code, id: '102' }).to_return(body: 'ERROR')
      expect(client.delete_message_via_id('102')).to have_key(:code)
      expect(client.delete_message_via_id('102')[:code]).to eq(422)
    end
  end

  context '#delete_messages_all' do
    it 'returns json success' do
      stub_request(:get, uri + '/delete_messages_all.php').with(query: { apicode: api_code }).to_return(body: 'SUCCESS')
      expect(client.delete_messages_all).to have_key(:code)
      expect(client.delete_messages_all[:code]).to eq(200)
    end

    it 'returns json error' do
      stub_request(:get, uri + '/delete_messages_all.php').with(query: { apicode: api_code }).to_return(body: 'ERROR')
      expect(client.delete_messages_all).to have_key(:code)
      expect(client.delete_messages_all[:code]).to eq(422)
    end
  end
end
