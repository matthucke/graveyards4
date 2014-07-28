class PhotosController < ApplicationController
  before_action :require_admin, only: [ :create, :edit, :update, :destroy ]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    redirect_to '/'
  end

  def debug
    path = params[:county].to_s.split('/')
    if path.empty?
      raise "usage: ?county=Illinois/Cook"
    end
    @county = County.find_by_path_elements(*path) or raise "county not found"
    @graveyards = @county.graveyards.includes(:visits, :photos => :user)
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  # This is not really used because photo uploads are done from graveyard#show
  def new
    graveyard = Graveyard.find(params.require(:graveyard_id))
    @photo = Photo.new(
        graveyard: graveyard
    )
    @photo.sort_order=@photo.default_sort_order
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    respond_to do |format|
      if @photo.save
        PhotoMaintenance::PostUpload.new(@photo).run
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json {
          render status: :created, json: {
              files: [ @photo.as_file_upload ]
          }
        }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(
          :upload, :graveyard_id, :plot_id, :person_id, :story_id,
          :caption, :sort_order
      )
    end
end
