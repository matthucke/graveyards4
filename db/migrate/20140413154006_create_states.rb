class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :state_code
      t.string :country_code
      t.string :name
      t.string :path

      t.timestamps
    end
  end
end
