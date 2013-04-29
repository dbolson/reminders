require 'spec_helper'
require 'reminders/configuration'

describe Reminders::Configuration do
  describe '#access_token' do
    context 'when specified' do
      before do
        Reminders::configure do |config|
          config.access_token = 'access-token'
        end
      end

      after do
        Reminders.configuration = nil
      end

      it 'sets the access token' do
        expect(Reminders.configuration.access_token).to eq('access-token')
      end
    end

    context 'when not specified' do
      before do
        Reminders::configure do |config|
        end
      end

      it 'defaults to nil' do
        expect(Reminders.configuration.access_token).to be_nil
      end
    end
  end
end
