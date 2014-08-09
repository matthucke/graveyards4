=begin

=end
# require 'file_utils'

class Photo < ActiveRecord::Base
  include Uploadable

  DOC_ROOT = '/www/graveyards4/htdocs'

  STATUS_NEW = 0
  STATUS_REJECTED=13
  STATUS_APPROVED=100

  belongs_to :user #, :counter_cache=>true
  belongs_to :graveyard, :counter_cache=>true
  belongs_to :county #, :counter_cache=>true
  # belongs_to :plot
  # has_and_belongs_to_many :people

  validates :graveyard_id, presence: true
  validates :user_id, presence: true
  configure_upload :upload, "#{Rails.root}/config/photo_uploads.yml"
  validates :upload, presence: true, on: :create

  before_destroy :prepare_for_death

  def path
    @path ||= ImagePath.new(id, image_dir, :format=>self.format)
  end

  def read_file
    File.read(path.physical, mode: 'rb')
  end

  def thumbnail_path
    @thumbnail_path ||= ThumbPath.new(id, image_dir)
  end

  def image_dir
    g=self.graveyard or return nil
    words = g.full_path.split('/')
    words.pop
    words.join('/')
  end

  # Response format as desirphoted by https://github.com/blueimp/jQuery-File-Upload
  def as_file_upload
    as_json(:only=>[:id, :graveyard_id, :user_id, :caption, :sort_order]).merge({
        name: upload_file_name,
        size: upload_file_size,
        url: path.virtual,
        thumbnailUrl: thumbnail_path.virtual,
        deleteType: 'DELETE',
        deleteUrl: "/photos/#{id}"
    })
  end

  def default_sort_order
    if g=self.graveyard
      return  100 * (1 + g.photos.count)
    end
    nil
  end

  # invoked by before_destroy callback.
  def prepare_for_death
    path.destroy!
    thumbnail_path.destroy!

    if g=self.graveyard
      if g.main_photo_id == self.id
        puts "* removing as main photo for #{g.name}"
        g.main_photo=nil
        g.main_photo_id=nil
        g.save
      end
    end

    true
  end
end
