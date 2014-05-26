class GalleryImagePresenter
  attr_accessor :image

  def initialize(image)
    @image=image
  end

  def as_json(*args)
    return nil unless @image

    stuff = {
      id: @image.id,
      path: @image.path.virtual,
      caption: @image.caption,
      #attrs: @image.attributes.keys
    }.merge(user_attributes)
  end

  def user_attributes
    #@user = @image.user  or return({})
    @user = User.first

    {
        username: @user.username,
        owner_full_name: @user.full_name,
        ua: @user.attributes.keys
    }
  end
end