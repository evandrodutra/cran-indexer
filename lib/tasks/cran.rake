namespace :cran do
  desc 'Fetch cran-r packages and update database records'
  task update: :environment do
    packages = Cran::PackageList.new(limit: 50).fetch!

    packages.each do |package|
      CreatePackage.create!(package)
    end
  end
end
