require 'spec_helper'
require 'reminders'
require 'reminders/client'

describe Reminders::Client do
  let(:client) { Reminders::Client }

  describe '#event_lists' do
    it 'retrieves a json response' do
      response = %Q{
        'event_lists': [
          {
            'id':3,
            'name':'name',
            'created_at':'2013-04-19T13:14:24Z',
            'updated_at':'2013-04-19T13:14:24Z'
          },
          {
            'id':2,
            'name':'another name',
            'created_at':'2013-04-17T15:12:20Z',
            'updated_at':'2013-04-19T13:06:37Z'
          }
        ],
        'status':200
      }
      stub_request(:get,
                   'http://localhost:3000/api/v1/event_lists?access_token=access_token')
        .to_return(body: response)
      expect(client.new('access_token').event_lists).to eq({
        'event_lists' => [
          {
            'id' => 3,
            'name' => 'name',
            'created_at' => '2013-04-19T13:14:24Z',
            'updated_at' => '2013-04-19T13:14:24Z'
          },
          {
            'id' => 2,
            'name' => 'another name',
            'created_at' => '2013-04-17T15:12:20Z',
            'updated_at' => '2013-04-19T13:06:37Z'
          }
        ],
        'status' => 200
      })
    end
  end
end
