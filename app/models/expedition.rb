class Expedition < ActiveRecord::Base
  belongs_to :user

  has_many :visits

  default_scope { order('started_on')}
end
