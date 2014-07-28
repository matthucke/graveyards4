class AddPhotosCountToGraveyards < ActiveRecord::Migration
  def change
    add_column :graveyards, :photos_count, :integer, :default=>0

    Graveyard.record_timestamps=false
    graveyard_ids = Graveyard.all.map(&:id).sort
    graveyard_ids.each do |id|
      print "#{id} "
      Graveyard.reset_counters(id, :photos)
    end
  end
end

