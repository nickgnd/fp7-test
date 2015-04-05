class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :organisation_name
      t.string :organisation_short_name
      t.string :organization_url
      t.string :country
      t.string :street
      t.string :city
      t.string :post_code
      t.string :province
      t.integer :sum_shares
      t.integer :num_projects
      t.string :programmes
      t.integer :num_programmes

      t.timestamps null: false
    end
  end
end
