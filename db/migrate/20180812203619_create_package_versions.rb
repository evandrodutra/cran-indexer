class CreatePackageVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :package_versions do |t|
      t.references :package
      t.string     :title
      t.string     :version
      t.text       :description
      t.datetime   :publication_date

      t.timestamps
    end
  end
end
