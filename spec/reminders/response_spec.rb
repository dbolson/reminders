require 'spec_helper'
require 'reminders/response'

describe Reminders::Response do
  let(:response) { Reminders::Response.new }

  describe '#get' do
    it 'parses the json response' do
      expect(response.parse('{"fake":"response"}'))
        .to eq({ 'fake' => 'response' })
    end
  end
end
