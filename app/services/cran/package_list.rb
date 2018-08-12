module Cran
  class PackageList
    def initialize(limit: nil)
      @limit = limit
    end

    def fetch!
      information_list[0..query_size].map do |info|
        Package.load(name: info[:package], version: info[:version])
      end
    end

    private

    def information_list
      @information_list ||= Parser.parse(fetch_package_list)
    end

    def fetch_package_list
      Client.get('PACKAGES').body
    end

    def query_size
      (@limit || information_list.size) - 1
    end
  end
end
