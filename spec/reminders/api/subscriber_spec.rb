require 'spec_helper'
require 'reminders/api/base'
require 'reminders/api/subscriber'

describe Reminders::Api::Subscriber do
  let(:event) { Reminders::Api::Subscriber }
  let(:instance) { event.new(response, params) }
  let(:response) { JSON.parse(File.read('spec/fixtures/subscriber.json')) }
  let(:params) {{ status: 200 }}

  context 'as an api object' do
    let(:object) { event }

    it_behaves_like 'an api object'
  end

  describe '#phone_number' do
    specify do
      expect(instance.phone_number).to eq('15555555555')
    end
  end
end
