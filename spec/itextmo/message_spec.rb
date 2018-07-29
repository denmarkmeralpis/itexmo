require_relative '../spec_helper'

RSpec.describe Itexmo::Message do
  let(:message) { 'Your awesome message here!' }
  let(:to) { '09177710296' }
  let(:client) { Itexmo::Message.send(message: message, to: to) }
  let(:host) { 'https://www.itexmo.com/php_api/api.php' }

  before do
    Itexmo.configure do |config|
      config.api_code = ENV['ITEXMO_API_CODE']
    end
  end

  describe '#send' do
    context 'success response' do
      it 'returns success message' do
        stub_request(:post, host).to_return(body: '0')

        expect(client).to have_key(:message)
        expect(client[:code]).to eq(200)
      end
    end

    context 'failed response' do
      it 'raises error for invalid parameter to' do
        stub_request(:post, host).to_return(body: '1')
        expect { Itexmo::Message.send(message: message, to: 'invalid-to') }.to raise_error(Itexmo::Errors::BadRequest)
      end

      it 'raises error for unsupported number prefix' do
        stub_request(:post, host).to_return(body: '2')
        expect { client }.to raise_error(Itexmo::Errors::BadRequest)
      end

      it 'raises authentication error' do
        stub_request(:post, host).to_return(body: '3')
        expect { client }.to raise_error(Itexmo::Errors::Authentication)
      end

      it 'returns json error for max message reached' do
        stub_request(:post, host).to_return(body: '4')
        expect(client).to have_key(:code)
        expect(client[:code]).to eq(400)
      end

      it 'raises error for max allowed character reached' do
        stub_request(:post, host).to_return(body: '5')
        expect { client }.to raise_error(Itexmo::Errors::BadRequest)
      end

      it 'returns json error due to OFFLINE server' do
        stub_request(:post, host).to_return(body: '6')
        expect(client).to have_key(:code)
        expect(client[:code]).to eq(422)
      end

      it 'raises authentication error for expired api_code' do
        stub_request(:post, host).to_return(body: '7')
        expect { client }.to raise_error(Itexmo::Errors::Authentication)
      end

      it 'returns json error due to OFFLINE server' do
        stub_request(:post, host).to_return(body: '8')
        expect(client).to have_key(:code)
        expect(client[:code]).to eq(500)
      end

      it 'raises error for invalid function parameter' do
        stub_request(:post, host).to_return(body: '9')
        expect { client }.to raise_error(Itexmo::Errors::BadRequest)
      end

      it 'returns json error due to OFFLINE server' do
        stub_request(:post, host).to_return(body: '10')
        expect(client).to have_key(:code)
        expect(client[:code]).to eq(422)
      end

      it 'returns json error due to OFFLINE server' do
        stub_request(:post, host).to_return(body: '11')
        expect(client).to have_key(:code)
        expect(client[:code]).to eq(422)
      end

      it 'raises error for invalid non corporate api_code' do
        stub_request(:post, host).to_return(body: '12')
        expect { Itexmo::Message.send(message: message, to: '09171234567', priority: 'HIGH') }.to raise_error(Itexmo::Errors::BadRequest)
      end

      it 'raises error for unregistered sender id' do
        stub_request(:post, host).to_return(body: '13')
        expect { client }.to raise_error(Itexmo::Errors::BadRequest)
      end
    end
  end
end
