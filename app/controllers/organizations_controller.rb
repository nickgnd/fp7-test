class OrganizationsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    @model = "organization" # Set model
    @default_sort = "id" # Set default sort
    @organizations = Organization.search(params[:search], sort_column(@model, @default_sort), sort_direction)
    @organizations = @organizations.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end


  def show
    if params[:id]
      @organization = Organization.find(params[:id])

      if params[:organization_extra_id]
        @organization_extra = Organization.find(params[:organization_extra_id])
      else
        @graph = Organization.create_graph_of_single_node(@organization.id)
        @num_nodes = @graph["nodes"].size
        @num_edges = @graph["edges"].size
        @num_main_edges = OrganizationConnection.get_all_organization_connections_from_organization_id(@organization.id).size
      end

    end

    respond_to do |format|
      if params[:organization_extra_id]
        format.js
        format.json {render json: @organization_extra }
      else
        format.html
        format.json { render json: @graph }     # Graph of the single node (include edges between nodes linked at original node)
      end
      end
  end


  # # At the moment it's impossible to draw the whole graph because it crashes the browser
  # # Define some initial filter !!!
  # def graph
  #   # if params[:nodes]
  #   nodes = [1,2,3,4,5]
  #     @graph = Organization.create_graph_from_nodes(nodes)

  #   respond_to do |format|
  #     format.html # graph.html.erb
  #     format.json { render json: @graph }     # I create a JSON of the graph for Sigma.js
  #   end
  # end



  private

  def sort_column(model, default_sort)
    if model == "organization"
      Organization.column_names.include?(params[:sort]) ? params[:sort] : default_sort
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

end
