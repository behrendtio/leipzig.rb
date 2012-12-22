require 'leipzig/client'

module Leipzig
  class Calendar < Leipzig::Client
    TYPES = [:events, :hosts, :venues]
  end
end
