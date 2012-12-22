require 'leipzig/client'

module Leipzig
  class Mediahandbook < Leipzig::Client
    TYPES = [:companies, :branches, :people]
  end
end
