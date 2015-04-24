class ProjectsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @model = "project" # Set model
    @default_sort = "reference" # Set default sort
    @projects = Project.order_by(sort_column(@model, @default_sort), sort_direction)
    @projects = @projects.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    if params[:id]
      @project = Project.find(params[:id])

      if (@project.organization_id == 0 or @project.organization_id.to_s.empty?)
        @coordinator = "-"
      else
        @coordinator = Organization.find(@project.organization_id)
      end


      respond_to do |format|
        format.html
        # format.json { render json: @graph }     # Graph of the single node (include edges between nodes linked at original node)
      end
    end
  end


  private

  def sort_column(model, default_sort)
    if model == "project"
      Project.column_names.include?(params[:sort]) ? params[:sort] : default_sort
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

end
