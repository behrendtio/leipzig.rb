require 'leipzig/client'

module Leipzig
  class Mediahandbook < Leipzig::Client

    TYPES   = [:companies, :branches, :people]
    API_URL = 'http://www.apileipzig.de/api/v1/mediahandbook/'

    TYPES.each do |type|
      define_method "find_#{type}" do |*args|
        find(type, *args)
      end
    end

    def initialize(api_key)
      super
      @options = { :limit => 10, :name => 'leipzig', :api_key => @api_key }
    end

    def find(type, conditions)
      raise "Type #{type} is invalid" unless TYPES.include?(type.to_sym)
      request("#{API_URL}#{type}/search", conditions)
    end
  end
end
