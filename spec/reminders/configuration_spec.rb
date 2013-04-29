require 'spec_helper'
require 'reminders/configuration'

describe Reminders::Configuration do
  before do
    Reminders::configure do |config|
    end
  end

  describe 'with an access token' do
    before do
      Reminders::configure do |config|
        config.access_token = 'access token'
      end
    end

    specify do
      expect(Reminders.configuration.access_token)
        .to eq('access token')
    end
  end
end
