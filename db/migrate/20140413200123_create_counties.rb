class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.references :state, index: true
      t.integer :county_type, :default=>0
      t.string :name
      t.string :path
      t.string :full_path

      t.timestamps
    end
  end
end
