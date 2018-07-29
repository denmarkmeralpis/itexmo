require_relative '../spec_helper'

RSpec.describe Itexmo::Service do
  let(:client) { Itexmo::Service }
  let(:uri) { 'https://www.itexmo.com/php_api' }
  let(:api_code) { ENV['ITEXMO_API_CODE'] }

  before do
    Itexmo.configure do |config|
      config.api_code = ENV['ITEXMO_API_CODE']
    end
  end

  context '#status' do
    it 'returns success' do
      response = '{"result":{"APIStatus":"ONLINE","DedicatedServer":"NO","GatewayNumber":"", "SMSServerStatus":""} }'
      stub_request(:get, uri + '/serverstatus.php').with(query: { 'apicode' => api_code }).to_return(body: response)
      expect(client.status).to be_a(Hash)
    end
  end

  context '#apicode_info' do
    it 'returns success' do
      response = '{"Result ":{ "ApiCode":"TR-NUJIA710296_CP86J", "ContactNumber":"09177710296", "MaxCharacters":"100", "MaxMessages":"10", "MessagesLeft":"9", "Footer":"ITEXMO", "ExpiresOn":"2018-08-27", "Dedicated":"NO"}}'
      stub_request(:get, uri + '/apicode_info.php').with(query: { 'apicode' => api_code }).to_return(body: response)
      expect(client.apicode_info).to be_a(Hash)
    end
  end
end
