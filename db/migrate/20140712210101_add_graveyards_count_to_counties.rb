class AddGraveyardsCountToCounties < ActiveRecord::Migration
  def change
    add_column :counties, :graveyards_count, :integer, :default=>0

    county_ids = County.all.map(&:id)
    county_ids.each do |id|
      County.reset_counters(id, :graveyards)
    end
  end
end
