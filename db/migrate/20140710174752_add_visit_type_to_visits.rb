class AddVisitTypeToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :status, :string, default: 'visited', limit: 10
    add_column :visits, :visibility, :integer, default: 1000
  end
end
