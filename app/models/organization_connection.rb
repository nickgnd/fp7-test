class OrganizationConnection < ActiveRecord::Base

  # OLD structure of the table
  # belongs_to :organization_a, foreign_key: "organization_a_id", class_name: "Organization"
  # belongs_to :organization_b, foreign_key: "organization_b_id", class_name: "Organization"

  belongs_to :organization_a, foreign_key: "source", class_name: "Organization"
  belongs_to :organization_b, foreign_key: "target", class_name: "Organization"


  # Method to retrieve all organization connections of single organization (id)
  def self.get_all_organization_connections_from_organization_id(id)
    edges = []
    edges =  OrganizationConnection.select('id','source','target').where("source = ? OR target = ?", id, id)
    return edges
  end

  # Method to retrieve all the edges between one or more organizations
  def self.get_all_connections_between_organizations(nodes)
    edges = []
    if (!nodes.empty?)
      # SELECT `organization_connections`.`id`, `organization_connections`.`source`, `organization_connections`.`target`
      # FROM `organization_connections` WHERE `organization_connections`.`source` IN /NODES/
      # AND `organization_connections`.`target` IN /NODES/
      # Allow self-loop
      edges = OrganizationConnection.select('id','source','target').where(source: nodes).where(target: nodes)
    end
    return edges
  end

end
