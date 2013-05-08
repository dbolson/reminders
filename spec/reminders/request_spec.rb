require 'spec_helper'
require 'reminders/configuration'
require 'reminders/request'

describe Reminders::Request do
  let(:request) { Reminders::Request }
  let(:response) { '{"response":"body"}' }

  describe '#get' do
    it 'retrieves a json response' do
      stub_request(:get, 'url').to_return(body: response, status: 200)
      expect(request.get('url')).to eq(response)
    end

    context 'without a resource to return' do
      it 'retrieves a json response' do
        stub_request(:get, 'url').to_return(body: response, status: 404)
        expect(request.get('url')).to eq(response)
      end
    end
  end

  describe '#post' do
    context 'with a valid response' do
      it 'retrieves a json response' do
        stub_request(:post, 'url')
          .with(body: { fake: 'param' })
          .to_return(body: response, status: 200)
        expect(request.post('url', fake: 'param')).to eq(response)
      end
    end

    context 'with an invalid response' do
      it 'retrieves a json response' do
        stub_request(:post, 'url')
          .with(body: { fake: 'param' })
          .to_return(body: response, status: 422)
        expect(request.post('url', fake: 'param')).to eq(response)
      end
    end
  end

  describe '#put' do
    context 'with a valid response' do
      it 'retrieves a json response' do
        stub_request(:put, 'url')
          .with(body: { fake: 'param' })
          .to_return(body: response, status: 200)
        expect(request.put('url', fake: 'param')).to eq(response)
      end
    end

    context 'with an invalid response' do
      it 'retrieves a json response' do
        stub_request(:put, 'url')
          .with(body: { fake: 'param' })
          .to_return(body: response, status: 422)
        expect(request.put('url', fake: 'param')).to eq(response)
      end
    end
  end

  describe '#delete' do
    it 'retrieves a json response' do
      stub_request(:delete, 'url').to_return(body: response, status: 200)
      expect(request.delete('url')).to eq(response)
    end
  end
end
