require 'spec_helper'
require 'reminders/configuration'
require 'reminders/client'
require 'reminders/request'
require 'reminders/response'
require 'reminders/event_list'

describe Reminders::Client do
  let(:client) { Reminders::Client }

  describe '#initialize' do
    context 'with a specified access token' do
      it 'uses the specified access token' do
        expect(client.new('access-token').access_token)
          .to eq('access-token')
      end

      context 'with an access token set in the configuration' do
        before do
          Reminders::configure do |config|
            config.access_token = 'config-access-token'
          end
        end

        it 'uses the specifed access token' do
          expect(client.new('access-token').access_token)
            .to eq('access-token')
        end
      end
    end

    context 'without a specified access token' do
      context 'with an access token set in the configuration' do
        before do
          Reminders::configure do |config|
            config.access_token = 'access-token'
          end
        end

        after do
          Reminders::configuration = nil
        end

        it 'uses the configuration access token' do
          expect(client.new.access_token).to eq('access-token')
        end
      end

      context 'with no access token' do
        before do
          Reminders::configure do |config|
          end
        end

        it 'raises an exception' do
          expect {
            client.new.event_list('id')
          }.to raise_error(Reminders::UnauthorizedError,
                           'Please set your access token')
        end
      end
    end
  end

  describe '#event_list' do
    let(:response) { File.read('spec/fixtures/event_list.json') }

    before do
      Reminders::configure do |config|
        config.access_token = 'access-token'
      end

      stub_request(:get,
                   'http://localhost:3000/api/v1/event_lists/1?access_token=access-token')
        .to_return(body: response)
    end

    specify do
      expect(client.new('access-token').event_list(1).id).to eq(1)
    end
  end
end
