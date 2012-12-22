require 'rest-client'
require 'json'
require 'ostruct'

module Leipzig
  class Client
    API_URL   = 'http://www.apileipzig.de/api/v1'
    KEYWORDS  = [:limit, :offset, :format]

    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
      @conditions = { :limit => 10, :name => 'leipzig', :api_key => @api_key }
      register_methods
    end

    private

    def types
      self.singleton_class.const_get(:TYPES)
    end

    def find(type, conditions = {})
      raise "Type #{type} is invalid" unless types.include?(type.to_sym)
      uri = "#{API_URL}/#{resource}/#{type}"

      if has_search_param?(conditions)
        uri += '/search'
      end

      request(uri, conditions)
    end

    def has_search_param?(conditions)
      conditions.keys.select { |key| !KEYWORDS.include?(key) }.any?
    end

    def register_methods
      types.each do |type|
        self.class.send(:define_method, "find_#{type}".to_sym) do |*args|
          find(type, *args)
        end
      end
    end

    def resource
      self.class.to_s.split('::').last.downcase
    end

    def request(uri, conditions)
      result = JSON.parse RestClient.get(uri, :params => @conditions.merge(conditions))

      if result.has_key? "error"
        raise "API returned error for uri '#{uri}': #{result['error']}"
      end

      result['data'].map { |entry| OpenStruct.new(entry) }
    end
  end
end
