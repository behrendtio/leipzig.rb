require 'rest-client'
require 'json'
require 'ostruct'

module Leipzig
  class Client
    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
      @options = {}
    end

    private

    def request(uri, params)
      result = JSON.parse RestClient.get(uri, :params => @options.merge(params))

      if result.has_key? "error"
        raise "Webservice returned error for uri '#{uri}': #{result['error']}"
      end

      result['data'].map { |entry| OpenStruct.new(entry) }
    end
  end
end
