shared_examples_for 'a delegated api object' do
  let(:object_type) { api_class_name(object) }
  let(:response) { File.read("spec/fixtures/#{object_type}.json") }
  let(:instance) { Reminders::Client.new.send(object_type, id) }

  before do
    stub_request(:get,
                 "http://localhost:3000/api/v1/#{object_type}s/1?access_token=access-token")
      .to_return(body: response, status: 200)
  end

  specify { expect(instance).to be_a_kind_of(object) }
  specify { expect(instance.id).to eq(1) }
  specify { expect(instance.name).to eq('name') }
  specify { expect(instance.created_at).to eq('2000-01-01T00:00:00Z') }
  specify { expect(instance.updated_at).to eq('2000-01-01T00:00:01Z') }
  specify { expect(instance.status).to eq(200) }
end

shared_examples_for 'a delegated api object collection' do
  let(:object_type) { api_class_name(object) }
  let(:response) { File.read("spec/fixtures/#{object_type}s.json") }
  let(:instance) { Reminders::Client.new.send("#{object_type}s") }
  let(:instance1) { instance[0] }
  let(:instance2) { instance[1] }

  before do
    stub_request(:get,
                 "http://localhost:3000/api/v1/#{object_type}s/?access_token=access-token")
      .to_return(body: response, status: 200)
  end

  it "is a collection" do
    expect(instance1).to be_a_kind_of(object)
    expect(instance1.id).to eq(1)
    expect(instance2).to be_a_kind_of(object)
    expect(instance2.id).to eq(2)
  end

  specify { expect(instance1.status).to eq(200) }
  specify { expect(instance2.status).to eq(200) }
end

shared_examples_for 'it creates an instance' do
  let(:object_type) { api_class_name(object) }

  context 'with valid params' do
    let(:response) { File.read("spec/fixtures/#{object_type}.json") }
    let(:result) {
      client.new.send("create_#{object_type}", params)
    }

    before do
      stub_request(:post,
                   "http://localhost:3000/api/v1/#{object_type}s/?access_token=access-token")
        .with(body: { object_type.to_sym => params })
        .to_return(body: response, status: 201)
    end

    it 'creates an instance' do
      expect(result).to be_a_kind_of(object)
    end

    it 'saves all fields' do
      params.each do |k, v|
        expect(result.send(k)).to eq(v)
      end
    end

    specify { expect(result.status).to eq(201) }
  end

  context 'with invalid params' do
    let(:response) {
      File.read("spec/fixtures/#{object_type}_with_errors.json")
    }
    let(:result) {
      client.new.send("create_#{object_type}", params)
    }

    before do
      stub_request(:post,
                   "http://localhost:3000/api/v1/#{object_type}s/?access_token=access-token")
        .with(body: { object_type.to_sym => params })
        .to_return(body: response, status: 422)
    end

    it 'shows errors' do
      expect(result.id).to be_nil
      expect(result.errors).to eq(["Name can't be blank"])
    end

    specify { expect(result.status).to eq(422) }
  end
end

shared_examples_for 'it updates an instance' do
  let(:object_type) { api_class_name(object) }

  context 'with valid params' do
    let(:response) { File.read("spec/fixtures/#{object_type}.json") }
    let(:result) {
      client.new.send("update_#{object_type}", 1, params)
    }

    before do
    stub_request(:put,
                 "http://localhost:3000/api/v1/#{object_type}s/1?access_token=access-token")
      .with(body: { object_type.to_sym => params })
      .to_return(body: response, status: 200)
    end

    it 'updates the instance' do
      expect(result).to be_a_kind_of(object)
    end

    it 'updates all fields' do
      params.each do |k, v|
        expect(result.send(k)).to eq(v)
      end
    end

    specify { expect(result.status).to eq(200) }
  end

  context 'with invalid params' do
    let(:response) {
      File.read("spec/fixtures/#{object_type}_with_errors.json")
    }
    let(:result) {
      client.new.send("update_#{object_type}", 1, params)
    }

    before do
      stub_request(:put,
                   "http://localhost:3000/api/v1/#{object_type}s/1?access_token=access-token")
        .with(body: { object_type.to_sym => params })
        .to_return(body: response, status: 422)
    end

    it 'shows errors' do
      expect(result.name).to eq('')
      expect(result.errors).to eq(["Name can't be blank"])
    end

    specify { expect(result.status).to eq(422) }
  end
end

shared_examples_for 'it deletes an instance' do
  let(:object_type) { api_class_name(object) }
  let(:response) { File.read("spec/fixtures/#{object_type}.json") }
  let(:result) { client.new.send("delete_#{object_type}", 1) }

  before do
    stub_request(:delete,
                 "http://localhost:3000/api/v1/#{object_type}s/1?access_token=access-token")
        .to_return(body: response, status: 200)
  end

  it 'deletes the returned instance' do
    expect(result.send(field)).to eq('name')
  end

  specify { expect(result.status).to eq(200) }
end
