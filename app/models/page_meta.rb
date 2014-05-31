#
# Holds the meta information for a page.
#
class PageMeta
  attr_reader :contents, :canonical
  attr_accessor :main_image

  def initialize request=nil
    @site_name = SiteConfig.site_name
    @protocol = request ? request.protocol.to_s.gsub("://", '') : 'http'

    @contents = {}
    @main_image = '/images/title/title.jpg'

    if request
      self.canonical=request.path
    end
  end

  def get key, default=nil
    @contents[key] || default
  end

  def put key, value
    @contents[key] = value
  end

  def finalize
    @contents = {}.merge(facebook_stuff).merge(@contents)

    @contents
  end

  def put_if_nonblank key, value
    value.blank? ? nil : put(key,value)
  end

  def canonical=val
    @canonical=to_domain_url(val)
  end

  def import_from_page page
    put_if_nonblank :keywords, page.keywords
    put_if_nonblank :description, page.description
  end

  def fb_like_button(opts={})
    opts = {
      :layout=>:button_count,
      :width=>320,
      :show_faces=>false
    }.merge(opts || {})

    return ('<fb:like href="%s" layout="%s" show-faces="%s" width="%d" action="like" colorscheme="light" />' % [
      @canonical, opts[:layout], opts[:show_faces], opts[:width]
    ]).html_safe
  end

  def facebook_id
    Rails.application.secrets.facebook['app_id']
  end

  private

  def facebook_stuff
    return ({
        'fb:app_id' => facebook_id,
        'og:site_name' => SiteConfig.site_name,
        'og:url' => @canonical,
        'og:image' => to_domain_url(main_image)
    })
  end



  def to_domain_url(val)
    return val if val.blank?
    if val && !val.index('://')
      val = "/#{val}" unless val[0] == '/'
      val = "#{@protocol}://#{@site_name}#{val}"
    end
    val
  end
end