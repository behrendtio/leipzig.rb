module LeipzigHelpers
  def realworld_spec?
    'real' == ENV['API_TYPE']
  end
end
