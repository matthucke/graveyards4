module BuildsPath
  extend ActiveSupport::Concern

  module ClassMethods
    # Produce a clean name suitable for URLs
    # "New   York" => "New-York"
    def name_to_path_element name
      name.to_s.gsub(/[^A-Z0-9]+/i, ' ').strip.gsub(' ', '-')
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

  def included(base)
    base.extend(ClassMethods)
  end
end