class AddExpeditionIdToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :ordinal, :integer
    add_reference :visits, :expedition, index: true
  end
end
