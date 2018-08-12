require 'rails_helper'

RSpec.describe Cran::Package do
  it 'returns the package information from zip file' do
    VCR.use_cassette('cran-package-a3') do
      package = Cran::Package.load(name: 'A3', version: '1.0.0')

      expect(package.name).to eq('A3')
      expect(package.authors).to eq([])
      expect(package.maintainers).to eq([{ name: 'Roe', email: 'scottfr@berkeley.edu' }])
      expect(package.version).to eq('1.0.0')
      expect(package.date_publication).to eq('2015-08-16 23:05:52')
      expect(package.title).to eq('Accurate, Adaptable, and Accessible Error Metrics for Predictive Models')
      expect(package.description).to eq('Supplies tools for tabulating and analyzing '\
        'the results of predictive models. The methods employed are applicable '\
        'to virtually any predictive model and make comparisons between different '\
        'methodologies straightforward.')
    end
  end
end
