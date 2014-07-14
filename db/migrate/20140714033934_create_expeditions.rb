class CreateExpeditions < ActiveRecord::Migration
  def change
    create_table :expeditions do |t|
      t.references :user, index: true
      t.string :name
      t.date :started_on
      t.date :ended_on
      t.text :notes

      t.timestamps
    end
  end
end
