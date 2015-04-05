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
    # I create a JSON of the network
    @graph = {"nodes":[ {"id": "chr1","label": "Bob","size": 8.75 },
              {"id": "chr10", "label": "Alice", "size": 14.75 }],
              "edges":[ {"id": "1","source": "chr1","target": "chr10"} ]}

    respond_to do |format|
      format.html # graph.html.erb
      format.json { render json: @graph }
    end
  end

end
