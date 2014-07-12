class RenameVisitsVisitType < ActiveRecord::Migration
  def change
    rename_column :visits, :visited_at, :visited_on
    rename_column :visits, :visit_type, :quality
  end
end
