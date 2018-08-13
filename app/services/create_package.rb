class CreatePackage
  def self.create!(*args)
    new(*args).create!
  end

  def initialize(package)
    @package = package
  end

  def create!
    package = Package.find_or_create_by(name: @package.name)
    version = package.package_versions.find_or_initialize_by(version: @package.version)

    version.title = @package.title
    version.description = @package.description
    version.publication_date = @package.date_publication
    version.save

    version.authors << authors
    version.maintainers << maintainers

    package
  end

  private

  def authors
    @package.authors.map do |attributes|
      contributor('author', attributes)
    end
  end

  def maintainers
    @package.maintainers.map do |attributes|
      contributor('maintainer', attributes)
    end
  end

  def contributor(role, attributes)
    Contributor.find_or_initialize_by(
      role: role,
      name: attributes[:name],
      email: attributes[:email]
    )
  end
end
