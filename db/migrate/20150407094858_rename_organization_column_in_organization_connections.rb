class RenameOrganizationColumnInOrganizationConnections < ActiveRecord::Migration
  def change
    change_table :organization_connections  do |t|
      t.rename :organization_a_id, :source
      t.rename :organization_b_id, :target
    end
  end
end
