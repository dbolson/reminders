def url
  "http://localhost:3000/api/v1/#{resource}?access_token=access-token"
end

shared_examples_for 'a delegated api object' do
  let(:object_type) { api_class_name(object) }
  let(:response) { File.read("spec/fixtures/#{object_type}.json") }

  before do
    stub_request(:get, url).to_return(body: response, status: 200)
  end

  specify { expect(instance).to be_a_kind_of(object) }
  specify { expect(instance.id).to eq(1) }
  specify { expect(instance.status).to eq(200) }
end

shared_examples_for 'a delegated api object collection' do
  let(:object_type) { api_class_name(object) }
  let(:response) { File.read("spec/fixtures/#{object_type}s.json") }
  let(:instance) { Reminders::Client.new.send("#{object_type}s") }
  let(:instance1) { instance[0] }
  let(:instance2) { instance[1] }

  before do
    stub_request(:get, url).to_return(body: response, status: 200)
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

    before do
      stub_request(:post, url)
        .with(body: { object_type.to_sym => params })
        .to_return(body: response, status: 201)
    end

    it 'creates an instance' do
      expect(instance).to be_a_kind_of(object)
    end

    it 'saves all fields' do
      params.each do |k, v|
        expect(instance.send(k)).to eq(v)
      end
    end

    specify { expect(instance.status).to eq(201) }
  end

  context 'with invalid params' do
    let(:response) {
      File.read("spec/fixtures/#{object_type}_with_errors.json")
    }

    before do
      stub_request(:post, url)
        .with(body: { object_type.to_sym => params })
        .to_return(body: response, status: 422)
    end

    it 'shows errors' do
      expect(instance.id).to be_nil
      expect(instance.errors).to_not be_empty
    end

    specify { expect(instance.status).to eq(422) }
  end
end

shared_examples_for 'it updates an instance' do
  let(:object_type) { api_class_name(object) }

  context 'with valid params' do
    let(:response) { File.read("spec/fixtures/#{object_type}.json") }

    before do
    stub_request(:put, url)
      .with(body: { object_type.to_sym => params })
      .to_return(body: response, status: 200)
    end

    it 'updates the instance' do
      expect(instance).to be_a_kind_of(object)
    end

    it 'updates all fields' do
      params.each do |k, v|
        expect(instance.send(k)).to eq(v)
      end
    end

    specify { expect(instance.status).to eq(200) }
  end

  context 'with invalid params' do
    let(:response) {
      File.read("spec/fixtures/#{object_type}_with_errors.json")
    }

    before do
      stub_request(:put, url)
        .with(body: { object_type.to_sym => params })
        .to_return(body: response, status: 422)
    end

    it 'shows errors' do
      expect(instance.id).to be_nil
      expect(instance.errors).to_not be_empty
    end

    specify { expect(instance.status).to eq(422) }
  end
end

shared_examples_for 'it deletes an instance' do
  let(:object_type) { api_class_name(object) }
  let(:response) { File.read("spec/fixtures/#{object_type}.json") }

  before do
    stub_request(:delete, url).to_return(body: response, status: 200)
  end

  it 'deletes the returned instance' do
    expect(instance.id).to eq(1)
  end

  specify { expect(instance.status).to eq(200) }
end
