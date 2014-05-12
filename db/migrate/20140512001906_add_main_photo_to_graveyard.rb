class AddMainPhotoToGraveyard < ActiveRecord::Migration
  def change
    add_reference :graveyards, :main_photo, index: true
  end
end
