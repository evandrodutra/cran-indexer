class CreateContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :contributors do |t|
      t.references :package_version
      t.string     :name
      t.string     :email
      t.integer    :role

      t.timestamps
    end
  end
end
