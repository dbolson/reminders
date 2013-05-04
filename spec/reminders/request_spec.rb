require 'spec_helper'
require 'reminders/configuration'
require 'reminders/request'

describe Reminders::Request do
  let(:request) { Reminders::Request }

  describe '#get' do
    it 'retrieves a json response' do
      response = '{"fake":"response"}'
      stub_request(:get,
                   'http://localhost:3000/api/v1/event_lists/id?access_token=access-token')
        .to_return(body: response, status: 200)
      expect(request.new('access-token').get('id')).to eq('{"fake":"response"}')
    end
  end

  describe '#post' do
    context 'with a valid response' do
      it 'retrieves a json response' do
        response = '{"fake":"response"}'
        stub_request(:post,
                     'http://localhost:3000/api/v1/event_lists?access_token=access-token')
          .to_return(body: response, status: 200)
        expect(request.new('access-token').post(fake: 'param')).to eq('{"fake":"response"}')
      end
    end

    context 'with an invalid response' do
      it 'retrieves a json response' do
        response = '{"fake":"response"}'
        stub_request(:post,
                     'http://localhost:3000/api/v1/event_lists?access_token=access-token')
          .to_return(body: response, status: 422)
        expect(request.new('access-token').post(fake: 'param')).to eq('{"fake":"response"}')
      end
    end
  end
end
