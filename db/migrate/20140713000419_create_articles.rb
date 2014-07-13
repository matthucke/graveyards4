class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :status, :default=>0
      t.integer :section, :default=>1
      t.references :graveyard, index: true
      t.references :author, index: true
      t.string :headline
      t.string :path
      t.datetime :published_at
      t.text :teaser
      t.text :body

      t.timestamps
    end
  end
end
