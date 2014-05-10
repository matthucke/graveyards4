class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :url
      t.string :username
      t.integer :security_level

      t.timestamps
    end
  end
end
