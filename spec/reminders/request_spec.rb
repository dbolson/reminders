require 'spec_helper'
require 'reminders/configuration'
require 'reminders/request'

describe Reminders::Request do
  let(:request) { Reminders::Request }
  let(:base_url) { 'http://localhost:3000/api/v1/event_lists' }
  let(:response) { '{"fake":"response"}' }

  describe '#get' do
    it 'retrieves a json response' do
      stub_request(:get, "#{base_url}/id?access_token=access-token")
        .to_return(body: response, status: 200)
      expect(request.new('access-token').get('id'))
        .to eq('{"fake":"response"}')
    end
  end

  describe '#post' do
    context 'with a valid response' do
      it 'retrieves a json response' do
        stub_request(:post, "#{base_url}?access_token=access-token")
          .to_return(body: response, status: 200)
        expect(request.new('access-token').post(fake: 'param'))
          .to eq('{"fake":"response"}')
      end
    end

    context 'with an invalid response' do
      it 'retrieves a json response' do
        stub_request(:post, "#{base_url}?access_token=access-token")
          .to_return(body: response, status: 422)
        expect(request.new('access-token').post(fake: 'param'))
          .to eq('{"fake":"response"}')
      end
    end
  end

  describe '#put' do
    context 'with a valid response' do
      it 'retrieves a json response' do
        stub_request(:put, "#{base_url}/id?access_token=access-token")
          .to_return(body: response, status: 200)
        expect(request.new('access-token').put('id', fake: 'param'))
          .to eq('{"fake":"response"}')
      end
    end

    context 'with an invalid response' do
      it 'retrieves a json response' do
        stub_request(:put, "#{base_url}/id?access_token=access-token")
          .to_return(body: response, status: 422)
        expect(request.new('access-token').put('id', fake: 'param'))
          .to eq('{"fake":"response"}')
      end
    end
  end

  describe '#delete' do
    it 'retrieves a json response' do
      stub_request(:delete, "#{base_url}/id?access_token=access-token")
        .to_return(body: response, status: 200)
      expect(request.new('access-token').delete('id'))
        .to eq('{"fake":"response"}')
    end
  end
end
