require 'leipzig/client'

module Leipzig
  class District < Leipzig::Client
    TYPES = [:districts, :streets, :statistics, :ihkcompanies]
  end
end
