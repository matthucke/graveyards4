class CountyPathIndex
  @@load_count = 0
  @@contents=nil

  CACHE_KEY = ("CountyPathIndex0000%s" % (Rails.env.test? ? '_t' : '')).freeze

  def self.contents
    @@contents ||= read_from_cache || read_from_database
  end

  def self.size
    contents.size
  end

  def self.find_id(path)
    contents[path]
  end

  def self.reset!
    Rails.cache.delete(CACHE_KEY)
    @@contents=nil
  end

  def self.load_count
    @@load_count
  end

private

  def self.read_from_cache
    Rails.cache.fetch(CACHE_KEY) { read_from_database }
  end

  def self.read_from_database
    @@load_count += 1
    County.all.inject({}) do |hash, c|
      hash[c.full_path]=c.id
      hash
    end
  end


end

