class AddMainPhotoToCounty < ActiveRecord::Migration
  def change
    add_reference :counties, :main_photo, index: true
  end
end
