require 'rubygems/package'
require 'zlib'

module Cran
  class Package
    attr_reader :name, :version, :date_publication, :title, :description, :authors, :maintainers

    def self.load(*args)
      package = new(*args)
      package.fetch_attributes
      package
    end

    def initialize(name:, version:)
      @name = name
      @version = version
      fetch_attributes
    end

    def fetch_attributes
      attributes = Parser.parse(content).first

      @date_publication = attributes[:date_publication]
      @title = attributes[:title]
      @description = attributes[:description]
      @authors = attributes[:author]
      @maintainers = attributes[:maintainer]
    end

    private

    def content
      Gem::Package::TarReader.new(zip) do |tar|
        tar.seek("#{@name}/DESCRIPTION") do |tarfile|
          return tarfile.read
        end
      end
    end

    def zip
      Zlib::GzipReader.new(package_source)
    end

    def package_source
      body = Client.get("#{@name}_#{@version}.tar.gz").body
      StringIO.new(body)
    end
  end
end
