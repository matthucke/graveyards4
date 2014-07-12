# Temp class so I can copy stuff from old DB.
class VisitMigration < ActiveRecord::Base
  self.table_name='visit_migrations'

  def to_visit
    Visit.new(
        user_id: 1,
        graveyard_id: graveyard_id,
        visited_at: (Date.parse(visitdate) rescue nil),  # dates like 11-jul-2003
        status: visited,
        notes: "import:#{visited};#{visitdate}"
    )
    #  VisitMigration.order(:graveyard_id).map(&:to_visit).map(&:save)

  end
end

=begin
  create view visit_migrations as
  select id, id as graveyard_id, visited, visitdate from
  graveyards_com.graveyards where visited>0;
=end
