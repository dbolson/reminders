require 'spec_helper'
require 'reminders/request'

describe Reminders::Request do
  let(:request) { Reminders::Request.new }

  describe '#get' do
    it 'retrieves a json response' do
      response = '{"fake":"response"}'
      stub_request(:get, 'http://example.com').to_return(body: response)
      expect(request.get('http://example.com'))
        .to eq('{"fake":"response"}')
    end
  end
end

