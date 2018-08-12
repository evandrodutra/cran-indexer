class PackageVersion < ApplicationRecord
  belongs_to :package

  validates :package, :title, :version, :description, presence: true
end
