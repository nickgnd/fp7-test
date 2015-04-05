class CreateOrganizationsProjects < ActiveRecord::Migration
  def change
    create_table :organizations_projects, :id => false do |t|
      t.integer :project_id
      t.integer :organization_id

      t.timestamps null: false
    end
  end
end
