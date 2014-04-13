class GraveyardsController < ApplicationController
  before_action :set_graveyard, only: [:show, :edit, :update, :destroy]

  # GET /graveyards
  # GET /graveyards.json
  def index
    @graveyards = Graveyard.all
  end

  # GET /graveyards/1
  # GET /graveyards/1.json
  def show
  end

  # GET /graveyards/new
  def new
    @graveyard = Graveyard.new
  end

  # GET /graveyards/1/edit
  def edit
  end

  # POST /graveyards
  # POST /graveyards.json
  def create
    @graveyard = Graveyard.new(graveyard_params)

    respond_to do |format|
      if @graveyard.save
        format.html { redirect_to @graveyard, notice: 'Graveyard was successfully created.' }
        format.json { render :show, status: :created, location: @graveyard }
      else
        format.html { render :new }
        format.json { render json: @graveyard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graveyards/1
  # PATCH/PUT /graveyards/1.json
  def update
    respond_to do |format|
      if @graveyard.update(graveyard_params)
        format.html { redirect_to @graveyard, notice: 'Graveyard was successfully updated.' }
        format.json { render :show, status: :ok, location: @graveyard }
      else
        format.html { render :edit }
        format.json { render json: @graveyard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graveyards/1
  # DELETE /graveyards/1.json
  def destroy
    @graveyard.destroy
    respond_to do |format|
      format.html { redirect_to graveyards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graveyard
      @graveyard = Graveyard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graveyard_params
      params.require(:graveyard).permit(:feature_type, :county_id, :status, :name, :path, :lat, :lng, :year_started, :usgs_id, :usgs_map, :homepage)
    end
end
