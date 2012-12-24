require 'leipzig/mediahandbook'
require 'leipzig/calendar'
require 'leipzig/district'
require 'webmock/rspec'
require_relative 'spec_helper'
require_relative 'response_builder'

describe 'Client' do
  before do
    if realworld_spec?
      WebMock.allow_net_connect!
    else
      stub_request(:get, /#{Leipzig::Client::API_URL}*/).to_return do |request|
        { :body => ResponseBuilder.new.response(request.uri.query_values) }
      end
    end

    key = ENV['API_KEY'] ? ENV['API_KEY'] : 'mock'

    @clients = Array.new
    @clients << Leipzig::Mediahandbook.new(key)
    @clients << Leipzig::Calendar.new(key)
    @clients << Leipzig::District.new(key)
  end

  it 'makes API key accessible' do
    @clients.each { |client| client.should respond_to(:api_key) }
  end

  it 'responds to all types with according find method' do
    @clients.each do |client|
      client.class::TYPES.each do |type|
        client.should respond_to("find_#{type}")
      end
    end
  end

  it 'returns Array of OpenStructs for find_* methods' do
    @clients.each do |client|
      type = client.class::TYPES.first
      data = client.send("find_#{type}".to_sym)

      data.should be_instance_of(Array)
      data.size.should eq(10) # Default limit
      data.each { |entry| entry.should be_instance_of(OpenStruct) }
    end
  end

  it 'takes search and limit parameters into account' do
    zip = '04317'
    limit = 2

    data = @clients.first.find_companies(:limit => limit, :postcode => zip)
    data.size.should eq(limit)
    data.each { |company| company.postcode.should eq(zip) }
  end

  it 'raises exception if invalid key is used' do
    if realworld_spec?
      lambda { Leipzig::Mediahandbook.new('wrong').find_companies }.should raise_error
    end
  end

  it 'raises exception if undefined method is called' do
    @clients.each do |client|
      lambda { client.find_something }.should raise_error
    end
  end
end
