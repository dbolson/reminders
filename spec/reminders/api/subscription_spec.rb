require 'spec_helper'
require 'reminders/api/base'
require 'reminders/api/event_list'
require 'reminders/api/subscriber'
require 'reminders/api/subscription'

describe Reminders::Api::Subscription do
  let(:event) { Reminders::Api::Subscription }
  let(:instance) { event.new(response, params) }
  let(:response) { JSON.parse(File.read('spec/fixtures/subscription.json')) }
  let(:params) {{ status: 200 }}

  context 'as an api object' do
    let(:object) { event }

    it_behaves_like 'an api object'
  end

  describe '#event_list' do
    specify do
      expect(instance.event_list).to be_a_kind_of(Reminders::Api::EventList)
    end
  end

  describe '#subscription' do
    specify do
      expect(instance.subscriber).to be_a_kind_of(Reminders::Api::Subscriber)
    end
  end
end
