module BuildsPath
  extend ActiveSupport::Concern

  def to_url(suffix=nil)
    url=self.full_path or return nil
    unless suffix.blank?
      url += "/#{suffix}"
    end
    '/'+url
  end

  # Removed 2014-07 as it messes up edit/update paths.
  # def to_param
  #  self.full_path
  # end

  module ClassMethods
    # Produce a clean name suitable for URLs
    # "New   York" => "New-York"
    def name_to_path_element name
      name.to_s
        .gsub("'", '')  # John's => Johns
        .gsub(/[^A-Z0-9]+/i, ' ') # all other special chars become a space
        .strip.gsub(' ', '-')
    end

    def find_by_path_elements(*list)
      return nil if list.any?(&:blank?)

      full = list.map(&:to_s).join('/')
      return where(:full_path => full).first
    end
  end

  def set_default_path force=false
    if force || path.blank?
      self.path = default_path
    end
  end

  def default_path
    self.class.name_to_path_element(name)
  end

  def set_default_full_path force=false
    set_default_path(force)
    if force || full_path.blank?
      self.full_path = default_full_path
    end
  end

  def default_full_path
    p = respond_to?(:parent) ? parent : nil
    if p && p != self
      p.set_default_full_path if p.full_path.blank?
      unless p.full_path.blank?
        return "#{p.full_path}/#{path}"
      end
    end
    nil
  end

end