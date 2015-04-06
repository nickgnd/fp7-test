class Organization < ActiveRecord::Base

  # Organization <-> Projects
  has_and_belongs_to_many  :projects


  # Organization <-> Organization

  # ! README !
  # This is a little trick to create a self join many-to-many relationship on the same model
  # The two declarations allow Bi-directional looped associations
  # To retrieve all the n-organization connesctions sum the two associations. Example:
  # all_connections = Organization.first.organization_A + Organization.first.organization_B (array)
  #(hack http://stackoverflow.com/questions/2168442/many-to-many-relationship-with-the-same-model-in-rails)

  # 1) Example -> Organization.first.organization_A
  # organization_A_connections "names" the OrganizationConnection join table for accessing through the organization_a association
  has_many :organization_A_connections, foreign_key: :organization_b_id, class_name: "OrganizationConnection"
  # source: :organization_a matches with the belong_to :organization_a identification in the OrganizationConnection model
  has_many :organizations_A, :through => :organization_A_connections, :source => :organization_a


  # 2) Example -> Organization.first.organization_B
  # organization_B_connections "names" the OrganizationConnection join table for accessing through the organization_b association
  has_many :organization_B_connections, foreign_key: :organization_a_id, class_name: "OrganizationConnection"
  # source: :organization_b matches with the belong_to :organization_b identification in the OrganizationConnection model
  has_many :organizations_B, through: :organization_B_connections, source: :organization_b



  #Methond to create a graph for Sigma.js
  def self.create_graph()

    #Example of a graph
    # @graph = {"nodes":[ {"id": "chr1","label": "Bob","size": 8.75 },
    #           {"id": "chr10", "label": "Alice", "size": 14.75 }],
    #           "edges":[ {"id": "1","source": "chr1","target": "chr10"} ]}

    nodes = []
    nodes.push(Organization.first)
    nodes += Organization.first.organizations_A
    nodes += Organization.first.organizations_B
    nodes_hash = nodes.map {|n| {id: n.id.to_s, label: n.organization_name, size: n.num_projects.to_i }}

    edges = []
    OrganizationConnection.where("organization_a_id = ? OR organization_b_id = ?", 1, 1).find_each do |org|
      edges.push([org.id, org.organization_a_id, org.organization_b_id])
    end
    edges_hash = edges.map {|e| {id: e[0].to_s, source: e[1].to_s, target: e[2].to_s }}

    graph = {}
    graph["nodes"] = nodes_hash
    graph["edges"] = edges_hash

    return graph

  end

end



