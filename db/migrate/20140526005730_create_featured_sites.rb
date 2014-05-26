class CreateFeaturedSites < ActiveRecord::Migration
  def change
    create_table :featured_sites do |t|
      t.string :section
      t.integer :sort_order
      t.references :graveyard, index: true
      t.string :url
      t.string :headline
      t.text :description

      t.timestamps
    end
  end
end
