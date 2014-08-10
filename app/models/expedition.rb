class Expedition < ActiveRecord::Base
  belongs_to :user

  has_many :visits
end
