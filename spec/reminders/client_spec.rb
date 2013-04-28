require 'spec_helper'
require 'reminders'
require 'reminders/client'

describe Reminders::Client do
  let(:client) { Reminders::Client.new('access_token') }
  let(:response) { File.read('spec/fixtures/event_lists.json') }

  describe '#event_lists' do
    it 'retrieves a json response' do
      stub_request(:get,
                   'http://localhost:3000/api/v1/event_lists?access_token=access_token')
        .to_return(body: response)
      expect(client.event_lists).to eq({
        'event_lists' => [
          {
            'id' => 1,
            'name' => 'name',
            'created_at' => '2013-04-19T00:00:00Z',
            'updated_at' => '2013-04-19T00:00:00Z'
          },
          {
            'id' => 2,
            'name' => 'another name',
            'created_at' => '2013-04-19T00:00:01Z',
            'updated_at' => '2013-04-19T00:00:01Z'
          }
        ],
        'status' => 200
      })
    end
  end
end
