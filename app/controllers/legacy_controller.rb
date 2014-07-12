class LegacyController < ApplicationController
  # Handles old URLs like:
  # http://dev.graveyards.com/graveyards/MO/St._Louis_City/Bellefontaine.kml
  def show
    if id=params[:id]
      if id.to_i > 0
        if @graveyard = Graveyard.find(id) rescue nil
          return redirect_to(@graveyard.to_url, :status =>301)
        end
      end
    end

    (state_path, county_path, grave_path) = params[:path].to_s.split('/', 3)
#    raise "ST=#{state_path} C=#{county_path} GN=#{grave_path}"

    (grave_path, fmt) = grave_path.to_s.split('.', 2)

    raise ActionController::RoutingError.new("bad graveyard path: #{grave_path}") if state_path.blank?

    if @state =find_state(state_path)
      if @county = find_county(@state, county_path)
        if @graveyard = find_graveyard(@county, grave_path)
          url = @graveyard.to_url
          unless url.blank?
            url += ".#{fmt}" unless fmt.blank?
            return redirect_to(url, :status=>301)
          end
        end
        return redirect_to(@county.to_url, :status=>301)
      end
      return redirect_to(@state.to_url, :status=>301)
    end

    raise @state.inspect
  end

private

  def find_graveyard county, graveyard_path
    g = lookup_graveyard(county, graveyard_path)
    return g if g

    if graveyard_path =~ /(.*)-Cemetery/
      g = lookup_graveyard(county, $1)
      return g if g
    else
      g = lookup_graveyard(county, "#{graveyard_path}-Cemetery")
      return g if g
    end

    nil
  end

  def lookup_graveyard county, graveyard_path
    Graveyard.where(:county_id=>county.id, :path=>graveyard_path).first
  end

  def find_state(state_path)
    state_path=state_path.to_s
    state_path.length > 2 ?
        State.where(:path=>state_path).first : State.where(:state_code=>state_path.upcase).first
  end

  def find_county(state, county_path)
    return nil if !state

    # transmogrify it from v3 munging to v4 munging...
    if county_path =~ %r/[\._\-]/
      county_path=county_path.gsub(%r/[\._\-]+/, '-')
    end
    County.where(:state_id=>state.id, :path=>county_path).first
  end
end
