class ProjectsController < ApplicationController
  def index
    @projects = Project.limit(10).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    if params[:id]
      @project = Project.find(params[:id])


      respond_to do |format|
        format.html
        # format.json { render json: @graph }     # Graph of the single node (include edges between nodes linked at original node)
      end
    end
  end
end
