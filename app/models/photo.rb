=begin

=end
# require 'file_utils'

class Photo < ActiveRecord::Base

  DOC_ROOT = '/www/graveyards4/htdocs'

  STATUS_NEW = 0
  STATUS_REJECTED=13
  STATUS_APPROVED=100

  belongs_to :user #, :counter_cache=>true
  belongs_to :graveyard #, :counter_cache=>true
  belongs_to :county #, :counter_cache=>true
  
  # belongs_to :plot
  # has_and_belongs_to_many :people

  def path
    @path ||= ImagePath.new(id, image_dir, :format=>self.format)
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

  def calculate_checksum
    Digest::MD5.file(path.physical).hexdigest
  end

  def file_contents
    contents=nil
    File.open(self.path.physical, "rb") do |fh|
      contents=fh.read
    end
    contents
  end
end
