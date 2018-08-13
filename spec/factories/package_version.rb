FactoryBot.define do
  factory :package_version do
    package
    title 'A project'
    version '1.0.0'
    description 'This is the A package'
    publication_date Time.zone.now
  end
end
