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

    describe '#event' do
      let(:object) { Reminders::Api::Event }
      let(:id) { 1 }

      it_behaves_like 'a delegated api object'
    end

    describe '#events' do
      let(:object) { Reminders::Api::Event }

      it_behaves_like 'a delegated api object collection'
    end

    describe '#create_event' do
      let(:object) { Reminders::Api::Event }
      let(:params) {{
        name: 'name',
        description: 'description',
        due_at: '2000-01-11T00:00:00Z'
      }}

      it_behaves_like 'it creates an instance'
    end

    describe '#update_event' do
      let(:object) { Reminders::Api::Event }
      let(:params) {{
        name: 'name',
        description: 'description',
        due_at: '2000-01-11T00:00:00Z'
      }}

      it_behaves_like 'it updates an instance'
    end

    describe '#delete_event' do
      let(:object) { Reminders::Api::Event }
      let(:field) { :name }

      it_behaves_like 'it deletes an instance'
    end

    describe '#event_list' do
      let(:object) { Reminders::Api::EventList }
      let(:id) { 1 }

      it_behaves_like 'a delegated api object'
    end

    describe '#event_lists' do
      let(:object) { Reminders::Api::EventList }

      it_behaves_like 'a delegated api object collection'
    end

    describe '#create_event_list' do
      let(:object) { Reminders::Api::EventList }
      let(:params) {{ name: 'name' }}

      it_behaves_like 'it creates an instance'
    end

    describe '#update_event_list' do
      let(:object) { Reminders::Api::EventList }
      let(:params) {{ name: 'name' }}

      it_behaves_like 'it updates an instance'
    end

    describe '#delete_event_list' do
      let(:object) { Reminders::Api::EventList }
      let(:field) { :name }

      it_behaves_like 'it deletes an instance'
    end
  end
end
