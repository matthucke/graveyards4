class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :state_code, :limit=>20
      t.string :country_code, :limit=>2
      t.string :name
      t.string :path
      t.integer :priority

      t.timestamps
    end
  end
end
