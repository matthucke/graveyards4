class Graveyard < ActiveRecord::Base
  include BuildsPath
  include GraveyardPath

  belongs_to :county
  belongs_to :main_photo, class_name: 'Photo'

  has_many :photos

  validates :county, presence: true
  validates :name, presence: true
  validates :path, presence: true

  validate :path_must_be_unique_in_county

  before_validation :set_default_path

  alias_attribute :parent, :county

  def main_photos
    active_photos.where(:plot_id=>nil, :story_id=>nil)
  end

  def active_photos
    photos.where(:status =>  Photo::STATUS_APPROVED)
  end

  def located?
    (lat && lat.abs > 0.001) || (lng && lng.abs > 0.001)
  end

  def map_data
    out = {
      id: self.id,
      name: self.name,
      url: self.to_url,
      # photo_count: self.photos_count
    }

    if located?
      out.merge!(
        lat: self.lat.to_f,     # 0.0 for unknowns.
        lng: self.lng.to_f    # 0.0 for unknowns.
      )
    end
    out
  end

end
