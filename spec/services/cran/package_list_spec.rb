require 'rails_helper'

RSpec.describe Cran::PackageList do
  it 'returns the packages list from cran-r server' do
    VCR.use_cassette('cran-packages-list') do
      list = Cran::PackageList.new(limit: 2).fetch!

      expect(list.count).to eq(2)
      expect(list.first.name).to eq('A3')
      expect(list.first.version).to eq('1.0.0')
      expect(list.first.date_publication).to eq('2015-08-16 23:05:52')
      expect(list.first.title).to eq('Accurate, Adaptable, and Accessible Error Metrics for Predictive Models')
    end
  end
end
