require 'spec_helper'
require 'reminders/api/base'
require 'reminders/api/account'

describe Reminders::Api::Account do
  let(:event) { Reminders::Api::Account }
  let(:instance) { event.new(response, params) }
  let(:response) { JSON.parse(File.read('spec/fixtures/account.json')) }
  let(:params) {{ status: 200 }}

  context 'as an api object' do
    let(:object) { event }

    it_behaves_like 'an api object'
  end

  describe '#email' do
    specify do
      expect(instance.email).to eq('test@example.com')
    end
  end
end
