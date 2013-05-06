require 'spec_helper'
require 'reminders/api/event_list'

describe Reminders::Api::EventList do
  let(:event_list) { Reminders::Api::EventList }
  let(:response) { JSON.parse(File.read('spec/fixtures/event_list.json')) }
  let(:params) {{ status: 200 }}

  describe '#status' do
    specify do
      expect(event_list.new(response, params).status).to eq(200)
    end
  end

  describe '#id' do
    specify do
      expect(event_list.new(response, params).id).to eq(1)
    end
  end

  describe '#name' do
    specify do
      expect(event_list.new(response, params).name).to eq('name')
    end
  end

  describe '#created_at' do
    specify do
      expect(event_list.new(response, params).created_at)
        .to eq('2000-01-01T00:00:00Z')
    end
  end

  describe '#updated_at' do
    specify do
      expect(event_list.new(response, params).updated_at)
        .to eq('2000-01-01T00:00:01Z')
    end
  end

  describe '#errors' do
    context 'with errors' do
      let(:response) {
        JSON.parse(File.read('spec/fixtures/event_list_with_errors.json'))
      }

      it 'displays a list of errors' do
        expect(event_list.new(response, params).errors)
          .to eq(["Name can't be blank"])
      end
    end

    context 'without errors' do
      specify do
        expect(event_list.new(response, params).errors).to be_nil
      end
    end
  end

  describe '#raw_response' do
    it 'shows the response string' do
      expect(event_list.new(response, params).raw_response)
        .to eq(File.read('spec/fixtures/event_list.json').gsub(/\n|\s/, ''))
    end
  end
end
