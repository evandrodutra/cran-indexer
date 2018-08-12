require 'rails_helper'

RSpec.describe PackageVersion, type: :model do
  context "Relations" do
    it { is_expected.to belong_to(:package) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:package) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:version) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
