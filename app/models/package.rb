class Package < ApplicationRecord
  has_many :package_versions

  validates :name, presence: true
end
