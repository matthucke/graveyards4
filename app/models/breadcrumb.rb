class Breadcrumb
  attr_accessor :url, :title

  def initialize(attrs={})
    attrs[:url].tap do |u|
      @url=u unless u.blank?
    end
    attrs[:title].tap do |t|
      @title=t unless t.blank?
    end
  end

  def self.new_from_request(request)
    b = Breadcrumb.new(:url => request.path, :title=>nil)
  end
end