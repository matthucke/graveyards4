class CreateGraveyards < ActiveRecord::Migration
  def change
    create_table :graveyards do |t|
      t.integer :feature_type, :default=>0
      t.references :county, index: true
      t.integer :status
      t.string :name
      t.string :path
      t.decimal :lat, :precision => 10, :scale => 6 
      t.decimal :lng, :precision => 10, :scale => 6 
      t.integer :year_started
      t.integer :usgs_id
      t.string :usgs_map
      t.string :homepage

      t.timestamps
    end
  end
end
