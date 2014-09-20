class GraveyardAlternatePathResolver < GraveyardPathResolver

  def graveyard
    @graveyard ||= find_by_alternate_paths
  end

  def find_by_alternate_paths
    return nil unless county_id && graveyard_path.present?

    candidate_paths.each do |p|
      if g=Graveyard.where(county_id: county_id, path: p).first
        return g
      end
    end

    nil
  end


  def candidate_paths
    simple_name = graveyard_path.gsub('-Cemetery', '').strip
    [
        simple_name,
        "#{simple_name}-Cemetery",
        "#{simple_name}-Mausoleum"
    ]
  end

  # Look up county (using the cache) only after fixing the state path.
  def county_id
    fix_state
    @county_id ||= super
  end


  # Fix legacy states like /IL, /MO...
  def fix_state
    if state_path.to_s.length == 2
      if state = State.where(state_code: state_path).first
        self.state_path = state.name
      end
    end
  end

end