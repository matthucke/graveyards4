class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :user, index: true
      t.references :graveyard, index: true
      t.date :visited_at
      t.integer :visit_type
      t.text :notes

      t.timestamps
    end
  end
end
