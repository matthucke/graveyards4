class MapsController < ApplicationController
  before_filter :maps_startup
  
  # Index for one County.
  def index
    load_county or raise "county not found"

    breadcrumbs.add(:url=>@state.to_url, :title=>@state.name)
    breadcrumbs.add(:url=>@county.to_url, :title=>@county.name)
    self.page_title = "#{@county.fancy_name_with_state} Cemetery Map"

    @graveyards = @county.graveyards.includes(:main_photo).includes(:county)

    respond_to do |fmt|
      fmt.json do
        render :json => {
          :status=>:success,
          :locations => @graveyards.sort_by(&:name).map(&:map_data)
        }
      end
      fmt.html { render :action=>:index }
    end
  end

  # Map of one graveyard.  Not yet implemented.
  def show
    raise params.inspect
    
    # TODO breadcrumbs
    
    
    respond_to do |fmt|
      fmt.html { render and return }
      fmt.kml { }
      fmt.json { }
    end
  end
  
  
  #def map
  #  load_county_with_graveyards or raise "county not found"
  #end
  
protected 

  def maps_startup
    key = Rails.application.secrets.google_maps['api_key']
    raise "No Google Maps API key." if key.blank?
    
    @extra_scripts ||= []
    # v2 api
    # @extra_scripts.push "http://maps.google.com/maps?file=api&v=2&key=#{key}"
    # v3 api
    @extra_scripts.push "https://maps.googleapis.com/maps/api/js?key=#{key}&libraries=geometry&sensor=false"
  end
  
  def load_county url=nil, opts={}
    @county = County.find_by_path_elements(params[:state], params[:county]) or return nil
    @state = @county.state
    @county
  end
  
  
end
