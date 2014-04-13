#
# A State represents a top-level division of a country.
#
# US: Illinois etc.
# UK: England, Scotland, etc.
# ...or could be the entirety of a small country.
#
# It has a :name (its correct name as generally used)
# and a :path (a simplified version of the name, for URLs)
#
class State < ActiveRecord::Base
  include BuildsPath

  has_many :counties

  validates :name, :presence=>true
  validates :country_code, :presence=>true
  validates :path, :presence=>true, :uniqueness => true

  before_validation :set_default_path

  # As the top level of the URL structure, full_path is the
  # same as path.
  def full_path
    path
  end
end
