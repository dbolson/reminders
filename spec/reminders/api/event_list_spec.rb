require 'spec_helper'
require 'reminders/api/base'
require 'reminders/api/subscriber'
require 'reminders/api/event_list'

describe Reminders::Api::EventList do
  let(:event_list) { Reminders::Api::EventList }
  let(:response) { JSON.parse(File.read('spec/fixtures/event_list.json')) }
  let(:params) {{ status: 200 }}

  context 'as an api object' do
    let(:object) { event_list }

    it_behaves_like 'an api object'
  end

  context '#subscriber' do
    let(:instance) { event_list.new(response, params) }
    let(:response) {
      JSON.parse(File.read('spec/fixtures/event_list.json'))
    }

    specify do
      expect(instance.subscriber(1)).to be_a_kind_of(Reminders::Api::Subscriber)
      expect(instance.subscriber(1).id).to eq(1)
    end
  end

  context '#subscribers' do
    let(:instance) { event_list.new(response, params) }
    let(:response) {
      JSON.parse(File.read('spec/fixtures/event_list.json'))
    }

    specify do
      expect(instance.subscribers[0]).to be_a_kind_of(Reminders::Api::Subscriber)
    end
  end
end
