require 'rest-client'
require 'json'
require 'ostruct'

module Leipzig
  class Client
    API_URL   = 'http://www.apileipzig.de/api/v1'
    KEYWORDS  = [:limit, :offset, :format]

    attr_reader :api_key

    # Constructor
    #
    # @param [String] API Key to use
    def initialize(api_key)
      @api_key = api_key
      @conditions = { :limit => 10, :name => 'leipzig', :api_key => @api_key }
      register_methods
    end

    private

    # Returns hash of TYPES for instance
    #
    # @return [Hash] Available types
    def types
      self.singleton_class.const_get(:TYPES)
    end

    # Generates URI and triggers API call
    #
    # @param [String] Type of resource to find
    # @param [Hash] Conditions
    # @return [Array] Result set of `request` method
    def find(type, conditions = {})
      raise "Type #{type} is invalid" unless types.include?(type.to_sym)

      uri = "#{API_URL}/#{resource}/#{type}"
      uri += '/search' if includes_search_param?(conditions)

      request(uri, conditions)
    end

    # Returns true if `conditions` hash includes non-keyword keys, hence search params
    #
    # @param [Hash] Conditions to check
    # @return [Boolean] True if search param was found
    def includes_search_param?(conditions)
      conditions.keys.select { |key| !KEYWORDS.include?(key) }.any?
    end

    # Registers find_*-methods for each TYPE on current instance
    def register_methods
      types.each do |type|
        self.class.send(:define_method, "find_#{type}".to_sym) do |*args|
          find(type, *args)
        end
      end
    end

    # Returns reource name based on instance class name
    # For instance "Leipzig::Mediahandbook" leads to "mediahandbook"
    #
    # @return [String] Resource name
    def resource
      self.class.to_s.split('::').last.downcase
    end

    # Calls API and returns Array which contains OpenStructs if entries were found
    #
    # @param [String] URI to call
    # @param [Hash] Conditions for call like limit, offset and search params
    # @return [Array] List of found entries
    def request(uri, conditions)
      result = JSON.parse RestClient.get(uri, :params => @conditions.merge(conditions))

      if result.has_key? 'error'
        raise "API returned error for uri '#{uri}': #{result['error']}"
      end

      result['data'].map { |entry| OpenStruct.new(entry) }
    end
  end
end
