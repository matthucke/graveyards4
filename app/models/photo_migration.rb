class PhotoMigration < ActiveRecord::Base
  #<PhotoMigration id: 1, county_id: 149,
  # graveyard_id: 1, contributor_id: 1,
  # contributor_name: "hucke",
  # old_path: "/IL/Cook/qi/acaciapark.jpg",
  # graveyard_name: "Acacia Park Cemetery",
  # created_at: "2014-05-25 23:06:48",
  # updated_at: "2014-05-25 23:06:48">

  attr_accessor :photo

  def to_photo
    @photo = Photo.new(
      :user_id => contributor_id,
      :graveyard_id => graveyard_id,
      :migration_id=>self.id,
      :migration_notes => "#{old_path};#{contributor_name}",
      :old_path => physical_path,
      :status=>100
    )
  end

  def physical_path
    "/www/graveyards4/htdocs#{old_path}"
  end

  def install_file
    @photo.save! unless @photo.id
    move_from = self.physical_path
    move_to = @photo.path.physical

    @photo.path.real_dir! # make directory

    # puts "mv #{move_from} #{move_to}"

    unless File.exist?(move_from)
      self.status = 'missing'
      self.save
      raise "source path missing: #{move_from}"
    end

    if File.exist?(move_to)
      self.status = 'collision'
      self.save
      raise "dest path exists: #{move_to}"
    end

    FileUtils.mv move_from, move_to, :verbose=>true
  end

  def perform!
    p = self.to_photo
    p.save
    install_file
    self.status = 'success'
    self.save
  rescue Exception => ex
    puts "ERROR IN #{self.id}: #{ex.message}"
    @photo.delete if @photo
    sleep 5
  end
end

