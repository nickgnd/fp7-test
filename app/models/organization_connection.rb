class OrganizationConnection < ActiveRecord::Base

  belongs_to :organization_a, foreign_key: "organization_a_id", class_name: "Organization"
  belongs_to :organization_b, foreign_key: "organization_b_id", class_name: "Organization"

end
