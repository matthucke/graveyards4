class ImagePath
  attr_accessor :id, :dir

  DOCUMENT_ROOT = SiteConfig.document_root

  def initialize(id, dir, opts={})
    @id=id
    @dir=dir
    @format = opts[:format]
  end

  def to_s
    virtual
  end

  def virtual
    "/pix/#{dir}/#{filename}"
  end

  def exists?
    File.exist? physical
  end

  def physical
    DOCUMENT_ROOT + virtual
  end

  def filename
    id = "%08x.%s" % [ self.id.to_i, self.format ]
  end

  def format
    @format.blank? ? 'jpg' : @format
  end

end