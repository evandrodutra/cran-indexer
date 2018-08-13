require 'rails_helper'

RSpec.describe PackageVersion, type: :model do
  context 'Relations' do
    it { is_expected.to belong_to(:package) }
    it { is_expected.to have_many(:authors).conditions(role: :author) }
    it { is_expected.to have_many(:maintainers).conditions(role: :maintainer) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:package) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:version) }
    it { is_expected.to validate_presence_of(:description) }
  end

  context 'Delegations' do
    it { is_expected.to delegate_method(:name).to(:package) }
  end
end
