class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true
      t.string :uid
      t.string :provider
      t.text :provider_text

      t.timestamps
    end
  end
end
