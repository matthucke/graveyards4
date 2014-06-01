class PhotosController < ApplicationController
  def index

  end

  def show

  end

  def debug
    path = params[:county].to_s.split('/')

    @county = County.find_by_path_elements(*path) or raise "county not found"
    @graveyards = @county.graveyards.includes(:visits, :photos => :user)
  end
end
