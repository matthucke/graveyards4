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

  validates :name, :presence=>true
  validates :country_code, :presence=>true
  validates :path, :presence=>true, :uniqueness => true

  before_validation :set_default_path
end
