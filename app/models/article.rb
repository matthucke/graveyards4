class Article < ActiveRecord::Base
  belongs_to :graveyard
  belongs_to :author, :class_name=> 'User'

  scope :published, -> {
    where(status: Article::STATUS_PUBLISHED)
    .includes(:author)
    .order('published_at desc')
  }

  STATUS_NEW = 0
  STATUS_PUBLISHED = 1000

  STATUS_OPTIONS = {
    STATUS_NEW => 'New',
    STATUS_PUBLISHED => 'Published'
  }
  SECTION_BLOG = 1

  SECTIONS = {
      SECTION_BLOG => 'blog'
  }

  def section_blog?
    SECTION_BLOG == self.section
  end

  def editable_by?(user=nil)
    user && user.admin?
  end
end
