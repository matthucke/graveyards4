class GraveyardsController < ApplicationController
  before_action :require_admin, only: [:edit, :update, :new, :create, :destroy]
  before_action :set_graveyard, only: [:edit, :update, :destroy]

  MAIN_STATE_ID = SiteConfig.fetch('main_state_id', nil)


  # GET /graveyards
  # GET /graveyards.json

  # This action would more properly be on StatesController - it's a list of states,
  # after all.  But historically it has been at the /graveyards URL.
  def index
    @states = State.includes(:counties).order(:priority => :desc, :name=>:asc)
    @main_state = @states.find { |s| s.id == MAIN_STATE_ID }

    # @visits will be used for county_summary
    @visit_summary = UserVisitsSummary.new(current_user)

    self.page_title="Cemetery Lists"
  end

  # GET /graveyards/1
  # GET /graveyards/1.json
  def show
    if params[:county].blank? && params[:id]
      @graveyard = Graveyard.find(params[:id])
      return redirect_to @graveyard.to_url, :status=>301
    else
      @graveyard = Graveyard.find_by_path_elements(params[:state], params[:county], params[:graveyard])
    end

    unless @graveyard
      if @graveyard = Graveyard.find_by_alternate_path("%s/%s/%s" % [
          params[:state], params[:county], params[:graveyard] ]
      )
        return redirect_to @graveyard.to_url, :status=>301
      end

      raise ActiveRecord::RecordNotFound
    end


    @graveyard=@graveyard.decorate

    if county = @graveyard.county
      if s=county.state
        @breadcrumbs.add(url: s.to_url, title: s.name)
      end
      cn = county.fancy_name_with_state
      self.page_title="#{@graveyard.name} - #{cn}"

      @breadcrumbs.add(url: county.to_url, title: cn)
      @breadcrumbs.here.title=@graveyard.name
    end

    if @main_image = @graveyard.main_photo || @graveyard.general_photos.first
      @page_meta.main_image = @main_image.path.to_s
    end
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
    raise "Destroy not implemented"
    
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
