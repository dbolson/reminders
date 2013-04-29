require 'spec_helper'
require 'reminders/event_list'

describe Reminders::EventList do
  let(:response) { JSON.parse(File.read('spec/fixtures/event_list.json')) }
  let(:event_list) { Reminders::EventList }

  describe '#id' do
    specify do
      expect(event_list.new(response).id).to eq(1)
    end
  end

  describe '#name' do
    specify do
      expect(event_list.new(response).name).to eq('name')
    end
  end

  describe '#created_at' do
    specify do
      expect(event_list.new(response).created_at).to eq('2013-04-19T00:00:00Z')
    end
  end

  describe '#updated_at' do
    specify do
      expect(event_list.new(response).updated_at).to eq('2013-04-19T00:00:01Z')
    end
  end

  describe '#status_code' do
    specify do
      expect(event_list.new(response).status_code).to eq(200)
    end
  end
end
