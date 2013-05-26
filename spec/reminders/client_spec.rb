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

  describe 'api methods' do
    before do
      Reminders::configure do |config|
        config.access_token = 'access-token'
      end
    end

    describe '#account' do
      let(:object) { Reminders::Api::Account }
      let(:instance) { Reminders::Client.new.account }
      let(:resource) { 'accounts' }

      it_behaves_like 'a delegated api object'
    end

    describe '#update_account' do
      let(:object) { Reminders::Api::Account }
      let(:instance) { Reminders::Client.new.update_account(params) }
      let(:resource) { 'accounts' }
      let(:params) {{ email: 'test@example.com' }}

      it_behaves_like 'it updates an instance'
    end

    describe '#event' do
      let(:object) { Reminders::Api::Event }
      let(:instance) { Reminders::Client.new.event(1) }
      let(:resource) { 'events/1' }

      it_behaves_like 'a delegated api object'
    end

    describe '#events' do
      let(:object) { Reminders::Api::Event }
      let(:instance) { Reminders::Client.new.events }
      let(:resource) { 'events' }

      it_behaves_like 'a delegated api object collection'
    end

    describe '#create_event' do
      let(:object) { Reminders::Api::Event }
      let(:instance) { Reminders::Client.new.create_event(params) }
      let(:resource) { 'events' }
      let(:params) {{
        name: 'name',
        description: 'description',
        due_at: '2000-01-11T00:00:00Z'
      }}

      it_behaves_like 'it creates an instance'
    end

    describe '#update_event' do
      let(:object) { Reminders::Api::Event }
      let(:instance) { Reminders::Client.new.update_event(1, params) }
      let(:resource) { 'events/1' }
      let(:params) {{
        name: 'name',
        description: 'description',
        due_at: '2000-01-11T00:00:00Z'
      }}

      it_behaves_like 'it updates an instance'
    end

    describe '#delete_event' do
      let(:object) { Reminders::Api::Event }
      let(:instance) { Reminders::Client.new.delete_event(1) }
      let(:resource) { 'events/1' }

      it_behaves_like 'it deletes an instance'
    end

    describe '#event_list' do
      let(:object) { Reminders::Api::EventList }
      let(:instance) { Reminders::Client.new.event_list(1) }
      let(:resource) { 'event_lists/1' }

      it_behaves_like 'a delegated api object'
    end

    describe '#event_lists' do
      let(:object) { Reminders::Api::EventList }
      let(:instance) { Reminders::Client.new.event_lists }
      let(:resource) { 'event_lists' }

      it_behaves_like 'a delegated api object collection'
    end

    describe '#create_event_list' do
      let(:object) { Reminders::Api::EventList }
      let(:instance) { Reminders::Client.new.create_event_list(params) }
      let(:resource) { 'event_lists' }
      let(:params) {{ name: 'name' }}

      it_behaves_like 'it creates an instance'
    end

    describe '#update_event_list' do
      let(:object) { Reminders::Api::EventList }
      let(:instance) { Reminders::Client.new.update_event_list(1, params) }
      let(:resource) { 'event_lists/1' }
      let(:params) {{ name: 'name' }}

      it_behaves_like 'it updates an instance'
    end

    describe '#delete_event_list' do
      let(:object) { Reminders::Api::EventList }
      let(:instance) { Reminders::Client.new.delete_event_list(1) }
      let(:resource) { 'event_lists/1' }
      let(:field) { :name }

      it_behaves_like 'it deletes an instance'
    end

    describe '#subscriber' do
      let(:object) { Reminders::Api::Subscriber }
      let(:instance) { Reminders::Client.new.subscriber(1) }
      let(:resource) { 'subscribers/1' }

      it_behaves_like 'a delegated api object'
    end

    describe '#subscribers' do
      let(:object) { Reminders::Api::Subscriber }
      let(:instance) { Reminders::Client.new.subscribers }
      let(:resource) { 'subscribers' }

      it_behaves_like 'a delegated api object collection'
    end

    describe '#create_subscriber' do
      let(:object) { Reminders::Api::Subscriber }
      let(:instance) { Reminders::Client.new.create_subscriber(params) }
      let(:resource) { 'subscribers' }
      let(:params) {{ phone_number: '15555555555' }}

      it_behaves_like 'it creates an instance'
    end

    describe '#update_subscriber' do
      let(:object) { Reminders::Api::Subscriber }
      let(:instance) { Reminders::Client.new.update_subscriber(1, params) }
      let(:resource) { 'subscribers/1' }
      let(:params) {{ phone_number: '15555555555' }}

      it_behaves_like 'it updates an instance'
    end

    describe '#delete_subscriber' do
      let(:object) { Reminders::Api::Subscriber }
      let(:instance) { Reminders::Client.new.delete_subscriber(1) }
      let(:resource) { 'subscribers/1' }
      let(:field) { :phone_number }

      it_behaves_like 'it deletes an instance'
    end

    describe '#create_subscription' do
      let(:object) { Reminders::Api::Subscription }
      let(:instance) { Reminders::Client.new.create_subscription(params) }
      let(:resource) { 'subscriptions' }
      let(:params) {{ event_list_id: '1', subscriber_id: '1' }}

      it_behaves_like 'it creates an instance'
    end
  end
end
