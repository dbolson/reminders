require 'spec_helper'
require 'reminders/api/event_list'

describe Reminders::Api::EventList do
  let(:event_list) { Reminders::Api::EventList }
  let(:response) { JSON.parse(File.read('spec/fixtures/event_list.json')) }
  let(:params) {{ status: 200 }}

  context 'as an api object' do
    let(:object) { event_list }

    it_behaves_like 'an api object'
  end
end
