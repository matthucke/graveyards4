class Graveyard < ActiveRecord::Base
  include BuildsPath
  include GraveyardPath

  belongs_to :county

  validates :county, :presence=>true
  validates :name, :presence=>true
  validates :path, :presence=>true

  validate :path_must_be_unique_in_county

  before_validation :set_default_path

  alias_attribute :parent, :county


end
