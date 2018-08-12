require 'rails_helper'

RSpec.describe Cran::Client do
  it 'returns files from cran-r server' do
    VCR.use_cassette("cran-packages") do
      response = Cran::Client.get('PACKAGES')

      expect(response.code).to eq(200)
      expect(response.body).to be_present
      expect(response.effective_url.to_s).to eq('https://cran.r-project.org:443/src/contrib/PACKAGES')
    end
  end
end
