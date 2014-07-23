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

  def real_dir
    DOCUMENT_ROOT + "/pix/#{dir}"
  end

  def real_dir!
    real_dir.tap do |d|
      FileUtils.mkdir_p d
    end
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

  def destroy!
    if exists?
      puts "[#{self.class}] deleting #{physical}"
      File.unlink(physical)
    else
      puts "[#{self.class}] skip deleting #{physical} - does not exist"
    end
  end
end