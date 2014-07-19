class AddAttachmentUploadToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.attachment :upload
      t.string :upload_fingerprint
    end
  end

  def self.down
    remove_attachment :photos, :upload
  end
end
