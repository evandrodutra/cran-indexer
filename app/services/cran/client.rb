module Cran
  class Client
    CRAN_SERVER_URL = 'https://cran.r-project.org/src/contrib/'

    def self.get(filename)
      Typhoeus.get("#{CRAN_SERVER_URL}#{filename}")
    end
  end
end
