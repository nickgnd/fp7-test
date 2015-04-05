class CreateOrganizationConnections < ActiveRecord::Migration
  def change
    create_table :organization_connections  do |t|
      t.integer :organization_a_id, :null => false
      t.integer :organization_b_id, :null => false
      t.integer :num_projects
      t.integer :sum_shares

      t.timestamps null: false
    end

  add_index :organization_connections, :organization_a_id
  add_index :organization_connections, :organization_b_id

  end
end
