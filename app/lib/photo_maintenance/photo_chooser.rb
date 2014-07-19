module PhotoMaintenance
  module PhotoChooser
    def choose_for_graveyards
      Graveyard.record_timestamps=false

      Graveyard.where(:main_photo_id=>nil).includes(:county, :photos).find_each do |g|
        choose_for_graveyard(g)
      end
    end

    def choose_for_graveyard(g)
      if p=g.photos.first
        g.main_photo_id=p.id
        g.save
      end
    end
  end
end

