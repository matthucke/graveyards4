class StatesController < ApplicationController
  before_action :require_admin, only: [  :edit, :update, :destroy]

  before_action :set_state, only: [:edit, :update, :destroy]

  # GET /states
  # GET /states.json
  def index
    @states = State.all
  end

  # GET /states/1
  # GET /states/1.json
  def show
    path = params[:state]
    unless path.blank?
      @state = State.where(:path => path.strip).first
    end
    raise ActiveRecord::RecordNotFound unless @state

    breadcrumbs.add(url: '/graveyards', title: 'Cemetery Lists')
    self.page_title = "#{@state.name} Cemetery Lists"
    breadcrumbs.here.title = @state.name

    # @visits will be used for county_summary
    @visit_summary = UserVisitsSummary.new(current_user)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:state_code, :country_code, :name, :path)
    end
end
