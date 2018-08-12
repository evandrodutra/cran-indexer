class Package < ApplicationRecord
  has_many :package_versions, dependent: :destroy

  validates :name, presence: true
end
