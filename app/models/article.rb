class Article < ActiveRecord::Base
  belongs_to :graveyard
  belongs_to :author, :class_name=> 'User'

  scope :published, -> {
    where(status: Article::STATUS_PUBLISHED)
    .includes(:author)
    .order('published_at desc')
  }

  def to_param
    path.present? ? path : id.to_s
  end

  STATUS_NEW = 0
  STATUS_PUBLISHED = 1000

  STATUS_OPTIONS = {
    STATUS_NEW => 'New',
    STATUS_PUBLISHED => 'Published'
  }

  SECTION_BLOG = 1
  SECTION_ABOUT = 2

  SECTIONS = {
      SECTION_BLOG => 'blog',
      SECTION_ABOUT => 'about'
  }

  def section_blog?
    SECTION_BLOG == self.section
  end

  def editable_by?(user=nil)
    user && user.admin?
  end
end
