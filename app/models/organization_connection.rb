class OrganizationConnection < ActiveRecord::Base

  # OLD structure of the table
  # belongs_to :organization_a, foreign_key: "organization_a_id", class_name: "Organization"
  # belongs_to :organization_b, foreign_key: "organization_b_id", class_name: "Organization"

  belongs_to :organization_a, foreign_key: "source", class_name: "Organization"
  belongs_to :organization_b, foreign_key: "target", class_name: "Organization"


  # Simple method to retrieve all organization connections of single organization (id)
  def self.get_all_organization_connections_from_organization_id(id)
    edges = []
    edges =  OrganizationConnection.select('id','source','target').where("source = ? OR target = ?", id, id)
    return edges
  end

end
