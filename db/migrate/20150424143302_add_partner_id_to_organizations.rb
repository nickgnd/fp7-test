class AddPartnerIdToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :partner_id, :integer, after: :id
  end
end
