require 'csv'

class CoordinatesController < ApplicationController
  def index
    state = State.find(1)
    counties = County.where(:state_id=>state.id)
    county_ids = counties.map(&:id)
    @points = Graveyard
      .where(:county_id => county_ids)
      .where("lat > 0.1 or lat < - 0.1")
      .includes(:county).order(:county_id, :name)

    #.where("lat >= 40.0")

    rows = @points.map { |p| graveyard_to_array(p) }.compact
    respond_to do |fmt|
      fmt.csv {
        text = rows_to_csv(rows)
        send_data(text, :type=>'text/csv; charset=utf-8',
        :filename => "#{state.name}.csv")
      }
      fmt.all { render :json=>rows }
    end
  end

private

  def rows_to_csv(rows)
    CSV.generate do |csv|
      rows.each do |row|
        csv << row
      end
    end
  end

  def graveyard_to_array(g)
    return nil unless g.lat.to_f.abs > 0.01 || g.lng.to_f.abs > 0.01
    return nil unless g.lat.to_f.abs < 89

    name = g.name.to_s
      .gsub(/Cemetery/i, 'Cem').gsub(/Mausoleum/i, 'Maus')
    if c=g.county
      name += " #{c.short_name.upcase}"
    end

    out = [ g.lng, g.lat, name ]
    out
  end
end
