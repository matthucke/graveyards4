class AddTypeNameToCounties < ActiveRecord::Migration
  def change
    add_column :counties, :type_name, :string, :default=>'County'
    remove_column :counties, :county_type
  end
end
