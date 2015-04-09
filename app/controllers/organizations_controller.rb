class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.limit(10)
  end

  def show
    if params[:id]
      @organization = Organization.find(params[:id])
    end
  end

  def graph
    # if params[:nodes]
    nodes = [1,2,3,4,5]
      @graph = Organization.create_graph_from_nodes(nodes)

    respond_to do |format|
      format.html # graph.html.erb
      format.json { render json: @graph }     # I create a JSON of the graph for Sigma.js
    end
  end

end
