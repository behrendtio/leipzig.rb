require 'rest-client'
require 'json'
require 'ostruct'

module Leipzig
  class Client
    TYPES   = [:companies, :branches, :people]
    API_URL = 'http://www.apileipzig.de/api/v1/mediahandbook/'

    attr_reader :api_key

    TYPES.each do |type|
      define_method "find_#{type}" do |*args|
        find(type, *args)
      end
    end

    def initialize(api_key)
      @api_key = api_key
      @options = { :limit => 10, :name => 'leipzig', :api_key => @api_key }
    end

    def find(type, conditions)
      raise "Type #{type} is invalid" unless TYPES.include?(type.to_sym)

      uri = "#{API_URL}#{type}/search"

      result = JSON.parse(RestClient.get(uri, :params => @options.merge(conditions)))

      if result.has_key? "error"
        raise "Webservice returned error for uri '#{uri}': #{result['error']}"
      end

      result['data'].map { |entry| OpenStruct.new(entry) }
    end
  end
end
