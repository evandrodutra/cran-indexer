class PackageVersion < ApplicationRecord
  belongs_to :package
  has_many :authors, -> { authors }, class_name: 'Contributor', dependent: :destroy
  has_many :maintainers, -> { maintainers }, class_name: 'Contributor', dependent: :destroy

  validates :package, :title, :version, :description, presence: true

  delegate :name, to: :package
end
