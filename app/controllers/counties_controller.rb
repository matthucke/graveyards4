class CountiesController < ApplicationController

  # GET /counties
  # GET /counties.json
  def index
    redirect_to :controller=>:graveyards
  end

  # GET /Illinois/Cook
  # Index for a single county, showing graveyards in that county.
  def show
    @county = County.find_by_path_elements(params[:state], params[:county]) or return not_found

    @county = @county.decorate

    @state=@county.state

    breadcrumbs.add(url: '/graveyards', title: 'Cemetery Lists')
    breadcrumbs.add(url: @state.to_url, title: "#{@state.name}")

    self.page_title=@county.fancy_name_with_state.to_s + " Cemeteries"
    breadcrumbs.here.title = @county.fancy_name_with_state.to_s + " Cemeteries"

    @graveyards = @county.graveyards.order(:name).includes(:county, :main_photo)
  end

end
