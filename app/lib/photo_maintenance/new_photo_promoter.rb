module PhotoMaintenance
  class NewPhotoPromoter
    attr_accessor :graveyard

    # PhotoMaintenance::NewPhotoPromoter.new.run
    def initialize(graveyard=nil)
      @graveyard=graveyard || Photo.last.graveyard
    end

    def run
      all_pics = @graveyard.photos.includes(:graveyard).order('sort_order').to_a
      new_pics = all_pics.select { |p| p.created_at > Time.now - 24.hours }
      old_pics = all_pics - new_pics

      puts "* today's pics: #{new_pics.length}"
      puts "* old pics: #{old_pics.length}"

      puts "* changing main photo: #{graveyard.main_photo_id} to #{new_pics.first.id}"
      graveyard.main_photo = new_pics.first
      graveyard.save

      old_pics.each do |p|
        s = p.default_sort_order
        puts "* putting #{p.id} at end with sort order #{s}"
        p.sort_order = s; p.save
      end
    end
  end
end