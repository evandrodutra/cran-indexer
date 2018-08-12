class Contributor < ApplicationRecord
  enum role: { author: 0, maintainer: 1 }

  belongs_to :package_version

  validates :package_version, :name, presence: true

  scope :authors, -> { where(role: :author) }
  scope :maintainers, -> { where(role: :maintainer) }
end
