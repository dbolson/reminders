shared_examples_for 'an api object' do
  let(:parsed_response) { JSON.parse(fixture_contents(object)) }
  let(:response) { fixture_contents(object) }
  let(:instance) { object.new(parsed_response, params) }

  describe '#status' do
    specify do
      expect(instance.status).to eq(200)
    end
  end

  describe '#id' do
    specify do
      expect(instance.id).to eq(1)
    end
  end

  describe '#name' do
    specify do
      expect(instance.name).to eq('name')
    end
  end

  describe '#created_at' do
    specify do
      expect(instance.created_at).to eq('2000-01-01T00:00:00Z')
    end
  end

  describe '#updated_at' do
    specify do
      expect(instance.updated_at).to eq('2000-01-01T00:00:01Z')
    end
  end

  describe '#errors' do
    context 'with errors' do
      let(:parsed_response) {
        JSON.parse(fixture_contents(object, :with_errors))
      }

      it 'displays a list of errors' do
        expect(instance.errors).to eq(["Name can't be blank"])
      end
    end

    context 'without errors' do
      specify do
        expect(instance.errors).to be_nil
      end
    end
  end

  describe '#raw_response' do
    it 'shows the response string' do
      expect(instance.raw_response).to eq(response.gsub(/\n|\s/, ''))
    end
  end
end
