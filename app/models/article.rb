class Article < ActiveRecord::Base
  belongs_to :graveyard
  belongs_to :author, :class_name=>:user

  STATUS_NEW = 0
  STATUS_PUBLISHED = 1000

  SECTION_BLOG = 1
  SECTIONS = {
      SECTION_BLOG => 'blog'
  }
end
