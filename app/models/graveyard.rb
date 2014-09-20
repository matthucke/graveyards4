class Graveyard < ActiveRecord::Base
  include BuildsPath
  include GraveyardPath

  belongs_to :county, counter_cache: true

  has_many :visits

  # Always load graveyard when loading main photo, because
  # main photo wants to do self.graveyard right away.
  # Without the 'includes', it would result in a
  # "1 + N" antipattern on the counties#show
  belongs_to :main_photo,
    -> { includes(:graveyard) },
    class_name: 'Photo'

  has_many :photos, -> { includes(:graveyard) }

  validates :county, presence: true
  validates :name, presence: true
  validates :path, presence: true

  validate :path_must_be_unique_in_county

  before_validation :set_default_path

  alias_attribute :parent, :county

  # General photos - those not associated with a plot/story.
  # These are the flagship photos for this graveyard and
  # show up in the gallery on graveyards#show
  def general_photos
    active_photos.where(:plot_id=>nil, :story_id=>nil)
  end

  def active_photos
    photos.where(:status =>  Photo::STATUS_APPROVED).order('sort_order, id')
  end

  def located?
    (lat && lat.abs > 0.001) || (lng && lng.abs > 0.001)
  end

  def path=(path)
    write_attribute(:path, path)
    self.full_path = default_full_path
  end

  def map_data
    out = {
      id: self.id,
      name: self.name,
      url: self.to_url,
      # photo_count: self.photos_count
      pic: main_photo ? main_photo.path.virtual : nil
    }

    if located?
      out.merge!(
        lat: self.lat.to_f,     # 0.0 for unknowns.
        lng: self.lng.to_f    # 0.0 for unknowns.
      )
    end
    out
  end

  # Search for deprecated paths...
  def self.find_by_alternate_path path
    path = path.to_s.gsub(%r{^/}, '').strip
    return nil if path.blank?

    # Trim -Cemetery$ if any, we'll replace it later.
    path = path.gsub(/-Cemetery$/i, '')

    # Map IL/Cook/foo to Illinois/Cook/foo
    if path =~ %r{^([A-Z][A-Z])/(.*)}
      state_code=$1
      rest=$2
      if state = State.where(state_code: state_code).first
        path = "#{state.name}/#{rest}"
      end
    end

    candidates = [
        path,
        "#{path}-Cemetery",
        "#{path}-Mausoleum"
    ]

    candidates.each do |alt|
      g = Graveyard.where(full_path: alt).first
      return g if g
    end

    # I give up.
    nil
  end
end
