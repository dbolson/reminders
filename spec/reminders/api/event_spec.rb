require 'spec_helper'
require 'reminders/api/event_list'
require 'reminders/api/event'

describe Reminders::Api::Event do
  let(:event) { Reminders::Api::Event }
  let(:response) { JSON.parse(File.read('spec/fixtures/event.json')) }
  let(:params) {{ status: 200 }}

  context 'as an api object' do
    let(:object) { event }

    it_behaves_like 'an api object'
  end

  describe '#event_list' do
    specify do
      expect(event.new(response, params).event_list)
        .to be_a_kind_of(Reminders::Api::EventList)
    end
  end

  describe '#due_at' do
    specify do
      expect(event.new(response, params).due_at)
        .to eq('2000-01-11T00:00:00Z')
    end
  end
end
