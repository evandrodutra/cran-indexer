require 'rails_helper'

RSpec.describe 'Search', type: :feature do
  before do
    pkg1 = create(:package, name: 'A3')
    pkg2 = create(:package, name: 'A2')
    create(:package_version, package: pkg1)
    create(:package_version, package: pkg2)
  end

  it 'List all packages' do
    visit '/'
    expect(page).to have_content 'A3'
    expect(page).to have_content 'A2'
  end

  it 'Search for a package' do
    visit '/?q=A3'
    expect(page).to have_content 'A3'
    expect(page).to_not have_content 'A2'
  end
end
