class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :update, :destroy]

  # GET /visits
  # GET /visits.json
  def index
    if current_user
      all_visits = Visit.for_user(current_User)
      @visits = all_visits.reject(&:todo?)
      @todos = all_visits.select(&:todo?)

    else
      redirect_to '/'
    end
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit ||= Visit.new(visit_params)

    # Get dates from most recently created visit records,
    # (not necessarily the most recent dates!)
    # and pick some for showing on the form
    @page_title = "Register Visit or To-Do"
    render_form
  end


  # GET /visits/1/edit
  def edit
    # look up the traditional way...
    if params[:id].to_i > 0
      set_visit
    # or look up by graveyard id.
    elsif (gid=params[:graveyard_id])
      @graveyard = Graveyard.find(gid)
      @visit = @graveyard.visits.where(user_id: current_user!.id).first
      return redirect_to(:action=>:new, 'visit[graveyard_id]'=> gid, :layout=>params[:layout]) unless @visit
    end

    @page_title = "Edit Visit or To-Do"
    render_form
  end

  # POST /visits
  # POST /visits.json
  def create
    @visit = Visit.new(visit_params)

    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, notice: 'Visit was successfully created.' }
        format.json { render :show, status: :created, location: @visit }
      else
        format.html { new }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  rescue Exception => ex
    render json: { error: ex.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /visits/1
  # PATCH/PUT /visits/1.json
  def update
    respond_to do |format|
      if @visit.update(visit_params)
        format.html { redirect_to @visit, notice: 'Visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @visit }
      else
        format.html { edit }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to visits_url, notice: 'Visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
  # for NEW / Edit
  def render_form(*render_args)
    @graveyard ||= @visit.graveyard or raise "cannot determine graveyard id"

    recent_visits = current_user!.visits.where("visited_on is not null").order("id desc").limit(10)
    @recent_dates = recent_visits.map(&:visited_on).map(&:to_s).reject(&:blank?).sort.reverse.uniq[0,3]

    @modal_size='lg'
    render_with_selected_layout(*render_args)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_visit
    @visit = Visit.find(params[:id])
    raise "Not authorized" unless @visit.visible_to?(current_user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def visit_params
    params.require(:visit).permit(
        :graveyard_id, :visited_on, :status, :notes, :quality, :visibility
    ).tap do |p|
      p[:user_id] = current_user!.id
    end
  end
end
