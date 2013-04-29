require 'spec_helper'
require 'reminders'
require 'reminders/client'

describe Reminders::Client do
  let(:client) { Reminders::Client.new('access_token') }
  let(:response) { File.read('spec/fixtures/event_lists.json') }

  describe '#event_lists' do
    it 'retrieves a json response' do
      pending
      stub_request(:get,
                   'http://localhost:3000/api/v1/event_lists?access_token=access_token')
        .to_return(body: response)
      expect(client.event_lists.raw_response).to eq({
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

  describe Reminders::EventList do
    let(:client) { Reminders::Client.new('access_token') }
    let(:response) { File.read('spec/fixtures/event_list.json') }
    let(:event_list) { Reminders::EventList }

    before do
      stub_request(:get,
                   'http://localhost:3000/api/v1/event_lists/id?access_token=access_token')
        .to_return(body: response)
    end

    describe '#id' do
      specify do
        expect(event_list.new('id').id).to eq('id')
      end
    end

    describe '#name' do
      specify do
        expect(event_list.new('id').name).to eq('name')
      end
    end

    describe '#created_at' do
      specify do
        expect(event_list.new('id').created_at).to eq('2013-04-19T00:00:00Z')
      end
    end

    describe '#updated_at' do
      specify do
        expect(event_list.new('id').updated_at).to eq('2013-04-19T00:00:01Z')
      end
    end

    describe '#status_code' do
      specify do
        expect(event_list.new('id').status_code).to eq(200)
      end
    end
  end
end
