class AddBoundaryToCounties < ActiveRecord::Migration
  def change
    add_column :counties, :boundary, :text
  end
end
