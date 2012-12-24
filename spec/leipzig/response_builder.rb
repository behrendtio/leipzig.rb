require 'json'

class ResponseBuilder
  DATA_FILE = File.expand_path('../companies.json', __FILE__)
  KEYS = %w{name api_key limit offset format}

  def initialize
    @json = JSON.parse(File.read(DATA_FILE), :symbolize_names => true)
  end

  def response(params)
    params = params.inject({}) { |param,(k,v)| param[k.to_sym] = v; param }
    data = @json[:data]

    if params.has_key?(:limit) && data.size > params[:limit].to_i
      data = data.first params[:limit].to_i
    end

    conditions = params.reject { |key| KEYS.include? key.to_s }
    @json[:data] = data.select { |e| (conditions.to_a - e.to_a).empty? }

    JSON.dump(@json)
  end
end
