class CountiesController < ApplicationController
  before_action :set_county, only: [:edit, :update, :destroy]

  # GET /counties
  # GET /counties.json
  def index
    redirect_to :controller=>:graveyards
  end

  # GET /Illinois/Cook
  # Index for a single county, showing graveyards in that county.
  def show
    @county = County.find_by_path_elements(params[:state], params[:county]) or return not_found
    @state=@county.state

    breadcrumbs.add(url: '/graveyards', title: 'Cemetery Lists')
    breadcrumbs.add(url: @state.to_url, title: "#{@state.name}")

    self.page_title=@county.fancy_name_with_state.to_s + " Cemetery List"
    breadcrumbs.here.title = @county.fancy_name_with_state.to_s + " Cemeteries"

    @graveyards = @county.graveyards.order(:name).includes(:county, :main_photo)
  end

  # GET /counties/new
  def new
    require_admin
    @county = County.new
  end

  # GET /counties/1/edit
  def edit
  end

  # POST /counties
  # POST /counties.json
  def create
    require_admin
    @county = County.new(county_params)

    respond_to do |format|
      if @county.save
        format.html { redirect_to @county, notice: 'County was successfully created.' }
        format.json { render :show, status: :created, location: @county }
      else
        format.html { render :new }
        format.json { render json: @county.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counties/1
  # PATCH/PUT /counties/1.json
  def update
    require_admin
    respond_to do |format|
      if @county.update(county_params)
        format.html { redirect_to @county, notice: 'County was successfully updated.' }
        format.json { render :show, status: :ok, location: @county }
      else
        format.html { render :edit }
        format.json { render json: @county.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counties/1
  # DELETE /counties/1.json
  def destroy
    require_admin
    @county.destroy
    respond_to do |format|
      format.html { redirect_to counties_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_county
      @county = County.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def county_params
      params.require(:county).permit(:state_id, :name, :type_name, :path, :full_path)
    end
end
