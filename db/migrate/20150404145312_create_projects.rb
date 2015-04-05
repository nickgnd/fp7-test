class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :reference
      t.string :acronym
      t.string :programme_pga
      t.string :programme_code
      t.string :subprogramme
      t.date :start_date
      t.date :end_date
      t.string :project_url
      t.integer :total_cost
      t.integer :ec_max_contribution
      t.string :call
      t.string :funding_scheme
      t.integer :organisation_id
      t.string :coordinator_country
      t.string :participant_countries
      t.string :countries
      t.string :subjects
      t.integer :num_countries
      t.integer :num_participants
      t.integer :num_uniquepart
      t.integer :share

      t.timestamps null: false
    end
  end
end
