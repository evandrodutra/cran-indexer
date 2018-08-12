require 'rails_helper'

RSpec.describe Package, type: :model do
  context 'Relations' do
    it { is_expected.to have_many(:package_versions) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
