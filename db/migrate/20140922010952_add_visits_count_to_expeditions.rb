class AddVisitsCountToExpeditions < ActiveRecord::Migration
  def change
    add_column :expeditions, :visits_count, :integer, default: 0

    Expedition.record_timestamps=false
    Visit.record_timestamps=false

    Expedition.all.each do |exp|
      print "#{exp.id} "
      Expedition.reset_counters(exp.id, :visits)
    end

  end
end
