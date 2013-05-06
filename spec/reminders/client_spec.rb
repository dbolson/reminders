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

    describe '#event_list' do
      let(:response) { File.read('spec/fixtures/event_list.json') }
      let(:result) { client.new.event_list(1) }

      before do
        stub_request(:get,
                     'http://localhost:3000/api/v1/event_lists/1?access_token=access-token')
          .to_return(body: response, status: 200)
      end

      specify { expect(result).to be_a_kind_of(Reminders::EventList) }
      specify { expect(result.id).to eq(1) }
      specify { expect(result.name).to eq('name') }
      specify { expect(result.created_at).to eq('2000-01-01T00:00:00Z') }
      specify { expect(result.updated_at).to eq('2000-01-01T00:00:01Z') }
      specify { expect(result.status).to eq(200) }
    end

    describe '#event_lists' do
      let(:response) { File.read('spec/fixtures/event_lists.json') }
      let(:result) { client.new.event_lists }
      let(:event_list1) { result[0] }
      let(:event_list2) { result[1] }

      before do
        stub_request(:get,
                     'http://localhost:3000/api/v1/event_lists/?access_token=access-token')
          .to_return(body: response, status: 200)
      end

      it 'is a collection of EventLists' do
        puts event_list1.inspect
        expect(event_list1).to be_a_kind_of(Reminders::EventList)
        expect(event_list1.id).to eq(1)
        expect(event_list2).to be_a_kind_of(Reminders::EventList)
        expect(event_list2.id).to eq(2)
      end

      specify { expect(event_list1.status).to eq(200) }
      specify { expect(event_list2.status).to eq(200) }
    end

    describe '#create_event_list' do
      context 'with valid params' do
        let(:response) { File.read('spec/fixtures/event_list.json') }
        let(:result) { client.new.create_event_list(name: 'name') }

        before do
          stub_request(:post,
                       'http://localhost:3000/api/v1/event_lists/?access_token=access-token')
            .to_return(body: response, status: 201)
        end

        it 'creates an event list' do
          expect(result).to be_a_kind_of(Reminders::EventList)
        end

        specify { expect(result.status).to eq(201) }
      end

      context 'with invalid params' do
        let(:response) {
          File.read('spec/fixtures/event_list_with_errors.json')
        }
        let(:result) { client.new.create_event_list(name: 'invalid') }

        before do
          stub_request(:post,
                       'http://localhost:3000/api/v1/event_lists/?access_token=access-token')
            .to_return(body: response, status: 422)
        end

        it 'shows errors' do
          expect(result.id).to be_nil
          expect(result.errors).to eq(["Name can't be blank"])
        end

        specify { expect(result.status).to eq(422) }
      end
    end

    describe '#update_event_list' do
      context 'with valid params' do
        let(:response) { File.read('spec/fixtures/event_list.json') }
        let(:result) { client.new.update_event_list(1, name: 'name') }

        before do
          stub_request(:put,
                       'http://localhost:3000/api/v1/event_lists/1?access_token=access-token')
            .to_return(body: response, status: 200)
        end

        it 'updates the event list' do
          expect(result).to be_a_kind_of(Reminders::EventList)
        end

        specify { expect(result.status).to eq(200) }
      end

      context 'with invalid params' do
        let(:response) {
          File.read('spec/fixtures/event_list_with_errors.json')
        }
        let(:result) { client.new.update_event_list(1, name: 'invalid') }

        before do
          stub_request(:put,
                       'http://localhost:3000/api/v1/event_lists/1?access_token=access-token')
            .to_return(body: response, status: 422)
        end

        it 'shows errors' do
          expect(result.name).to eq('')
          expect(result.errors).to eq(["Name can't be blank"])
        end

        specify { expect(result.status).to eq(422) }
      end
    end

    describe '#delete_event_list' do
      let(:response) { File.read('spec/fixtures/event_list.json') }
      let(:result) { client.new.delete_event_list(1) }

      before do
        stub_request(:delete,
                     'http://localhost:3000/api/v1/event_lists/1?access_token=access-token')
            .to_return(body: response, status: 200)
      end

      it 'deletes the event list' do
        expect(result.name).to eq('name')
        event_list = client.new.delete_event_list(1)
      end

      specify { expect(result.status).to eq(200) }
    end
  end
end
