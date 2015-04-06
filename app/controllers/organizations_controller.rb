class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
  end

  def show
    if params[:id]
      @organization = Organization.find(params[:id])
    end
  end

  def graph

    @graph = Organization.create_graph

    respond_to do |format|
      format.html # graph.html.erb
      format.json { render json: @graph }     # I create a JSON of the graph for Sigma.js
    end
  end

end
