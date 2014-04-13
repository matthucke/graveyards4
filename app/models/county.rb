class County < ActiveRecord::Base
  include BuildsPath

  belongs_to :state

  validates :name, :presence=>true
  validates :state, :presence=>true
  validates :path, :presence=>true
  validates :full_path, :presence=>true, :uniqueness => true

  before_validation :set_default_path, :set_default_full_path

  TYPE_COUNTY = 1
  TYPE_CITY = 2
  TYPE_PARISH = 3

  COUNTY_TYPES = {
    TYPE_COUNTY => 'County',
    TYPE_CITY => 'City',
    TYPE_PARISH => 'Parish'
  }

  def parent(*args)
    state(*args)
  end
end
