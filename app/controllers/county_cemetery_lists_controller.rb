class CountyCemeteryListsController < ApplicationController

  # GET /county_cemetery_lists
  # GET /county_cemetery_lists.json
  #
  # Not supported, go away.
  def index
    redirect_to url_for(:controller=>:graveyards)
  end

  # GET /county_cemetery_lists/1
  # GET /county_cemetery_lists/1.json
  def show
    @county = params[:county] ?
        County.find_by_path_elements(params[:state], params[:county]) :
        County.find_by_full_path(params[:id])

    raise ActiveRecord::RecordNotFound unless @county

    breadcrumbs.add(url: '/graveyards', title: 'Cemetery Lists')
    if @state=@county.state
      breadcrumbs.add(url: @state.to_url, title: "#{@state.name}")
    end
    breadcrumbs.add(url: @county.to_url, title: "#{@county.fancy_name_with_state}")

    self.page_title=@county.fancy_name_with_state.to_s + " Cemetery List"
    breadcrumbs.here.title = "List"

    @graveyards = @county.graveyards.order(:name).includes(:county, :main_photo)
  end

end
