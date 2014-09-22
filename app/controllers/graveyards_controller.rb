class GraveyardsController < ApplicationController
  respond_to :html, :json, :kml

  before_action :require_admin!, only: [:edit, :update, :new, :create, :destroy]
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
    result = ShowGraveyard.call(params: params, meta: page_meta, controller: self)

    @graveyard = result.graveyard or raise ActiveRecord::RecordNotFound
    # If accessed via a legacy path, redirect
    if result.redirect
      return redirect_to @graveyard.to_url, :status=>301
    end

    set_breadcrumbs_for_show
    respond_with(@graveyard)
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
    @graveyard.save and flash[:notice] = 'Graveyard was successfully created.'
    respond_with(@graveyard)
  end

  # PATCH/PUT /graveyards/1
  # PATCH/PUT /graveyards/1.json
  def update
    @graveyard.update(graveyard_params) and flash[:notice] = 'Graveyard was successfully updated.'
    respond_with(@graveyard)
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
    params.require(:graveyard).permit(
        :feature_type, :county_id, :status, :name, :path, :lat, :lng,
        :year_started, :usgs_id, :usgs_map, :homepage, :full_path)
  end

  def set_breadcrumbs_for_show
    if county = @graveyard.county
      if s=county.state
        @breadcrumbs.add(url: s.to_url, title: s.name)
      end
      cn = county.fancy_name_with_state

      # FIXME, not appropriate here.
      self.page_title="#{@graveyard.name} - #{cn}"

      @breadcrumbs.add(url: county.to_url, title: cn)
      @breadcrumbs.here.title=@graveyard.name
    end

    if @main_image = @graveyard.main_photo || @graveyard.general_photos.first
      @page_meta.main_image = @main_image.path.to_s
    end
  end

end
