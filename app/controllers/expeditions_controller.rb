class ExpeditionsController < ApplicationController
  before_action :current_user!

  before_action :set_expedition, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  # GET /expeditions
  # GET /expeditions.json
  def index
    @expeditions = current_user.expeditions
  end

  # GET /expeditions/1
  # GET /expeditions/1.json
  def show
  end

  # GET /expeditions/new
  def new
    @expedition = Expedition.new
  end

  # GET /expeditions/1/edit
  def edit
  end

  # POST /expeditions
  # POST /expeditions.json
  def create
    @expedition = Expedition.new(expedition_params)
    flash[:notice] = 'Expedition was successfully created.' if @expedition.save
    respond_with(@expedition)
  end

  # PATCH/PUT /expeditions/1
  # PATCH/PUT /expeditions/1.json
  def update
    respond_to do |format|
      if @expedition.update(expedition_params)
        format.html { redirect_to @expedition, notice: 'Expedition was successfully updated.' }
        format.json { render :show, status: :ok, location: @expedition }
      else
        format.html { render :edit }
        format.json { render json: @expedition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expeditions/1
  # DELETE /expeditions/1.json
  def destroy
    @expedition.destroy
    respond_to do |format|
      format.html { redirect_to expeditions_url, notice: 'Expedition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expedition
      @expedition = Expedition.find(params[:id]).tap do |e|
        require_owner_of(e)
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def expedition_params
      params.require(:expedition).permit(:user_id, :name, :started_on, :ended_on, :notes)
    end
end
