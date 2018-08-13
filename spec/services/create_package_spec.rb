require 'rails_helper'

RSpec.describe CreatePackage do
  let(:cran_package) do
    VCR.use_cassette('cran-package-a3') do
      Cran::Package.load(name: 'A3', version: '1.0.0')
    end
  end
  let!(:package) { CreatePackage.create!(cran_package) }

  it 'creates a package' do
    expect(package.name).to eq(cran_package.name)
  end

  it 'creates a version' do
    versions = package.package_versions

    expect(versions.count).to eq(1)
    expect(versions.first.title).to eq(cran_package.title)
    expect(versions.first.version).to eq(cran_package.version)
    expect(versions.first.description).to eq(cran_package.description)
    expect(versions.first.publication_date.to_s(:db)).to eq(cran_package.date_publication)
  end

  it 'creates authors' do
    authors = package.package_versions.first.authors

    # Ignores names and emails with wrong format rcf822
    expect(authors.count).to eq(0)
  end

  it 'creates maintainers' do
    maintainers = package.package_versions.first.maintainers

    expect(maintainers.count).to eq(1)
    expect(maintainers.first.name).to eq(cran_package.maintainers.first[:name])
    expect(maintainers.first.email).to eq(cran_package.maintainers.first[:email])
  end
end
