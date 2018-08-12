require 'rails_helper'

RSpec.describe Contributor, type: :model do
  context 'Relations' do
    it { is_expected.to belong_to(:package_version) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:package_version) }
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'Enums' do
    it { is_expected.to define_enum_for(:role).with(%i[author maintainer]) }
  end

  context 'Scopes' do
    before do
      create(:contributor, role: 'author')
      create(:contributor, role: 'maintainer')
    end

    it 'Returns authors' do
      result = Contributor.authors.all

      expect(result.count).to eq(1)
      expect(result.first.role).to eq('author')
    end

    it 'Returns maintainers' do
      result = Contributor.maintainers.all

      expect(result.count).to eq(1)
      expect(result.first.role).to eq('maintainer')
    end
  end
end
