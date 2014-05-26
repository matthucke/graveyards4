class GalleryPresenter
  attr_accessor :images

  def initialize(images)
    @images=images
  end

  def as_json(*args)
    images.map { |img| GalleryImagePresenter.new(img).as_json(*args) }
  end
end