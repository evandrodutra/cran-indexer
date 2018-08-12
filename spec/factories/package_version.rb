FactoryBot.define do
  factory :package_version do
    package
    title 'A3 project'
    version '1.0.0'
    description 'This is the A3 package'
    publication_date Time.zone.now
  end
end
