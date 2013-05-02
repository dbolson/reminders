require 'spec_helper'
require 'reminders'

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
            client.new
          }.to raise_error(Reminders::UnauthorizedError,
                           'Please set your access token')
        end
      end
    end
  end

  describe '#event_list' do
    let(:response) { File.read('spec/fixtures/event_list.json') }

    before do
      stub_request(:get,
                   'http://localhost:3000/api/v1/event_lists/1?access_token=access-token')
        .to_return(body: response)
    end

    it 'is an EventList' do
      expect(client.new('access-token').event_list(1).id).to eq(1)
    end
  end

  describe '#create_event_list' do
    context 'with valid params' do
      let(:response) { File.read('spec/fixtures/event_list.json') }

      before do
        stub_request(:post,
                     'http://localhost:3000/api/v1/event_lists?access_token=access-token')
          .to_return(body: response)
      end

      it 'creates an event list' do
        params = { event_list: { name: 'name' }}
        event_list = client.new('access-token').create_event_list(params)

        expect(event_list.id).to eq(1)
      end
    end

    context 'with invalid params' do
      let(:response) { File.read('spec/fixtures/event_list_with_errors.json') }

      before do
        stub_request(:post,
                     'http://localhost:3000/api/v1/event_lists?access_token=access-token')
          .to_return(body: response)
      end

      it 'shows errors' do
        params = { event_list: { name: 'invalid'}}
        event_list = client.new('access-token').create_event_list(params)

        expect(event_list.id).to be_nil
        expect(event_list.errors).to eq(["Name can't be blank"])
      end
    end
  end
end
