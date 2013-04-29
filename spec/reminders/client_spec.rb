require 'spec_helper'
require 'reminders/client'

describe Reminders::Client do
  let(:client) { Reminders::Client.new('access_token') }

  describe '#event_list' do
    before do
      stub_request(:get,
                   'http://localhost:3000/api/v1/event_lists/1?access_token=access_token')
        .to_return(body: response)
    end
    let(:response) { File.read('spec/fixtures/event_list.json') }

    specify { expect(client.event_list(1).id).to eq(1) }
  end
end
