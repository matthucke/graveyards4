class ThumbPath < ImagePath
  def filename
    id = "_%08x.%s" % [ self.id.to_i, self.format ]
  end

  def format
    @format.blank? ? 'png' : @format
  end

end