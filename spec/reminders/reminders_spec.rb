require 'spec_helper'
require 'reminders'

describe Reminders do
  describe '#event_lists', acceptance: true do
    context 'with valid credentials' do
      it 'retrieves a list of events' do
        expect(Reminders::Client.new('access_token').event_lists)
          .to eq([
            {
              'id' => 1,
              'name' => 'list 1',
              'created_at' => '2000-01-01T00:00:00Z',
              'updated_at' => '2000-01-01T00:00:00Z'
            },
            {
              'id' => 2,
              'name' => 'list 2',
              'created_at' => '2000-01-01T00:00:00Z',
              'updated_at' => '2000-01-01T00:00:00Z'
            }
          ])
      end
    end

    context 'with invalid credentials' do
      #it 'raises an exception'
    end
  end
end
