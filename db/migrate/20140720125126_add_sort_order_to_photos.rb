class AddSortOrderToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :sort_order, :integer
  end
end
