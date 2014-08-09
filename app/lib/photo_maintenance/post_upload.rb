
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

      # sort order, put at end
      set_sort_order

      # photos from admin users are auto-approved
      auto_approve

      # copy the files
      unless upload.blank?
        copy_main_image
        copy_thumbnail
      end

      # set as main photo
      offer_as_main_photo

      # read size of file - do this after installing it physically of course!
      PhotoMaintenance::Sizer.new.handle_photo(photo)

      photo.save if photo.changed?
    end

    # Photos uploaded by admin users are approved immediately.
    def auto_approve
      user=photo.user or return nil
      if user.admin?
        photo.approver_id=user.id
        photo.status = Photo::STATUS_APPROVED
      end
    end

    def set_sort_order
      g=photo.graveyard or return false
      photo.sort_order ||= 100 * (1 + g.photos.count)
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
      copy_image_file(upload.path(:big), photo.path.physical)
    end

    def copy_thumbnail(force=false)
      return :exists unless force or ! photo.thumbnail_path.exists?
      copy_image_file(upload.path(:thumb), photo.thumbnail_path.physical)
    end

    def copy_image_file src, dest
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