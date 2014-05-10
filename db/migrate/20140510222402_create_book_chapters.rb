class CreateBookChapters < ActiveRecord::Migration
  def change
    create_table :book_chapters do |t|
      t.string :qr_code, :limit=>40
      t.integer :section_id
      t.integer :sort_order
      t.references :graveyard, index: true
      t.string :title
      t.text :main_content

      t.timestamps
    end
  end
end
