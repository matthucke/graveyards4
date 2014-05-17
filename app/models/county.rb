class County < ActiveRecord::Base
  include BuildsPath

  belongs_to :state
  has_many :graveyards

  validates :name, :presence=>true
  validates :state, :presence=>true
  validates :path, :presence=>true
  validates :full_path, :presence=>true, :uniqueness => true

  before_validation :set_default_path, :set_default_full_path

  def parent(*args)
    state(*args)
  end

  # XXX County or City of XXX, as appropriate.
  # Note that a blank type_name will cause it to just return the name.
  def fancy_name
    case type_name.to_s
      when ''
        self.name
      when 'City'
        "City of #{name}"
      else
        [ name, type_name ].join(' ')
    end
  end

  def fancy_name_with_state
    s=self.state
    s ? ("#{fancy_name}, #{s.name}") : fancy_name
  end

  def self.find_by_path_elements state_path, county_path
    return nil if state_path.blank? || county_path.blank?

    joined = "#{state_path}/#{county_path}"
    return County.where(:full_path => joined).first
  end

  def encoded_boundary
    return nil if self.boundary.blank?
    return BoundaryEncoder.new.string_to_polyline(self.boundary)
  end
end
