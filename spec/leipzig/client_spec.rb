require 'leipzig/client'

KEY = ENV['API_KEY']
LIMIT = 5

describe 'Client' do
  let(:client) { Leipzig::Client.new(KEY) }

  it 'returns given API key' do
    client.api_key.should eq(KEY)
  end

  it 'reponds to all three mediahandbook types' do
    client.should respond_to(:find_branches)
    client.should respond_to(:find_companies)
    client.should respond_to(:find_people)
  end

  it 'returns json representation of resource with default limit' do
    data = client.find_companies(:limit => LIMIT)
    data.should be_instance_of(Array)
    data.size.should eq(LIMIT)
  end

  it 'takes search parameter into account' do
    zip = '04319'
    data = client.find_companies(:limit => 2, :postcode => zip)
    data.map { |company| company.postcode.should eq(zip) }
  end

  it 'raises exception if invalid key is used' do
    lambda { Leipzig::Client.new('wrong').find_companies }.should raise_error
  end

  it 'raises exception if undefined method is called' do
    lambda { client.find_something }.should raise_error
  end
end
