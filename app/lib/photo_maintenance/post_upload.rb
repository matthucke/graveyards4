module PhotoMaintenance
  class PostUpload
    attr_accessor :photo, :upload

    def initialize(photo)
      @photo=photo
      @upload=photo.upload
    end

    def run
      raise "for photo #{@photo.id} cannot find upload" unless upload

      # jpg png etc.
      set_format_from_upload

      # photos from admin users are auto-approved
      auto_approve

      # copy the files
      copy_main_image
      copy_thumbnail

      # set as main photo
      offer_as_main_photo
    end

    # Photos uploaded by admin users are approved immediately.
    def auto_approve
      user=photo.user or return nil
      if user.admin?
        photo.approver_id=user.id
        photo.status = Photo::STATUS_APPROVED
      end
    end

    # content_type to extension
    def set_format_from_upload
      ctype = upload.content_type.to_s.gsub('image/', '').downcase.gsub('jpeg', 'jpg')
      unless ctype.blank?
        @photo.format=ctype
      end
    end

    def copy_main_image(force=false)
      return :exists unless force or ! photo.path.exists?
      copy_image_file(upload.path(:mid), photo.path.physical)
    end

    def copy_thumbnail(force=false)
      return :exists unless force or ! photo.thumbnail_path.exists?
      copy_image_file(upload.path(:thumb), photo.thumbnail_path.physical)
    end

    def copy_image_file src, dest
      puts "WANT COPY #{src} #{dest}"
      FileUtils.cp(src, dest)
      raise "Failed to create #{dest}" unless File.exists?(dest)
      return :created
    end

    def offer_as_main_photo
      g=photo.graveyard or return false
      return if g.main_photo

      return if photo.person_id.to_i > 0
      set_as_main_photo
    end

    # Set as main photo for the owning graveyard
    def set_as_main_photo(force=true)
      g=photo.graveyard or return false

      g.main_photo_id = photo.id
      g.save
    end
  end
end