# Used by ShowGraveyard interactor, this looks up a graveyard from parsed path parameters.
class GraveyardPathResolver
  include ActiveModel::Model

  PATH_PARAMS = [ :state_path, :county_path, :graveyard_path, :extra_path ]
  attr_accessor *PATH_PARAMS

  def graveyard
    @graveyard ||= find_from_path
  end

  def find_from_path
    if cid=self.county_id
      Graveyard.where(county_id: cid, path: graveyard_path).first
    else
      Graveyard.where(full_path: full_path).first
    end
  end

  def full_path
    PATH_PARAMS.map { |pp| send(pp) }.compact.join('/')
  end

  def county_id
    CountyPathIndex.county_id("#{state_path}/#{county_path}")
  end

  ### CLASS METHODS ###

  # Given a graveyard, state or county (anything with full_path, return it, parsed)
  def self.params_from(pathy_thing)
    params_from_full_path(pathy_thing.full_path)
  end

  # @return Hash
  def self.params_from_full_path(full_path)
    Hash[ PATH_PARAMS.zip(full_path.split('/')) ]
  end

  def self.from_path(path)
    self.new(params_from_full_path(path))
  end
end
