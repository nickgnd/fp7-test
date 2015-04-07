class Organization < ActiveRecord::Base

  # Organization <-> Projects
  has_and_belongs_to_many  :projects


  # Organization <-> Organization

  # ! README !
  # This is a little trick to create a self join many-to-many relationship on the same model
  # The two declarations allow Bi-directional looped associations
  # To retrieve all the n-organization connesctions sum the two associations. Example:
  # all_connections = Organization.first.organization_A + Organization.first.organization_B (array od objects)
  #(hack http://stackoverflow.com/questions/2168442/many-to-many-relationship-with-the-same-model-in-rails)

  # OLD table structure
  # organization_A_connections "names" the OrganizationConnection join table for accessing through the organization_a association
  ## has_many :organization_A_connections, foreign_key: :organization_b_id, class_name: "OrganizationConnection"
  # source: :organization_a matches with the belong_to :organization_a identification in the OrganizationConnection model
  ## has_many :organizations_A, through: :organization_A_connections, source: :organization_a


  # The edges has a source (organization_a .id) and target (organization_b .id)

  # 1) call method .organizations_A
  ##   Example -> Organization.first.organizations_A to retrieve all "target" connections of first organization (where first.id is in "target" field)
  # organization_A_connections "names" the OrganizationConnection join table for accessing through the organization_a association
  has_many :organization_A_connections, foreign_key: :target, class_name: "OrganizationConnection"
  # source: :organization_a matches with the belong_to :organization_a identification in the OrganizationConnection model
  has_many :organizations_A, through: :organization_A_connections, source: :organization_a


  # 2) call method .organizations_B
  ##   Example -> Organization.first.organizations_B to retrieve all "source" connections of first organization (where first.id is in "source" field)
  # organization_B_connections "names" the OrganizationConnection join table for accessing through the organization_b association
  has_many :organization_B_connections, foreign_key: :source, class_name: "OrganizationConnection"
  # source: :organization_b matches with the belong_to :organization_b identification in the OrganizationConnection model
  has_many :organizations_B, through: :organization_B_connections, source: :organization_b



  # Methond to create a graph for Sigma.js
  def self.create_graph()

    #Example of a graph
    # @graph = {"nodes":[ {"id": "chr1","label": "Bob","size": 8.75 },
    #           {"id": "chr10", "label": "Alice", "size": 14.75 }],
    #           "edges":[ {"id": "1","source": "chr1","target": "chr10"} ]}

    nodes = []
    nodes.push(Organization.select('id','organization_name','num_projects').first)
    nodes += Organization.first.organizations_A.select('id','organization_name','num_projects')
    nodes += Organization.first.organizations_B.select('id','organization_name','num_projects')

    edges = []
    edges = OrganizationConnection.get_all_organization_connections_from_organization_id(1)

    graph = {}
    graph["nodes"] = nodes
    graph["edges"] = edges

    return graph
  end


  # Methond to create a graph for Sigma.js based on array of id
  def self.create_graph_from_nodes(array_of_nodes_id)
    nodes = []
    nodes = Organization.select('id','organization_name','num_projects').where(id: array_of_nodes_id)

    edges = []
    if !(nodes.empty?)
      edges = OrganizationConnection.get_all_connections_between_organizations(array_of_nodes_id)
    end

    graph = {}
    graph["nodes"] = nodes
    graph["edges"] = edges

    return graph
  end


  # -------------------------------------------------------
  # ALERT: browser crashes -> Too many nodes and edges (?)
  # -------------------------------------------------------
  def self.whole_graph()
    nodes = []
    nodes = Organization.select('id','organization_name','num_projects')

    edges = []
    edges = OrganizationConnection.select('id','source','target')

    graph = {}
    graph["nodes"] = nodes
    graph["edges"] = edges

    return graph
  end


end



