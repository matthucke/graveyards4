module PhotoMaintenance
  class Sizer

    def handle_photo(photo)
      if s = FastImage.size(photo.path.physical)
        photo.width=s.first
        photo.height=s.last
      end

      s
    rescue Exception => ex
      puts "error sizing photo #{photo.id}: #{ex}"
      nil
    end
  end
end