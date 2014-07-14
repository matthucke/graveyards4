class AddExpeditionIdToVisits < ActiveRecord::Migration
  def change
    add_reference :visits, :expedition, index: true
  end
end
