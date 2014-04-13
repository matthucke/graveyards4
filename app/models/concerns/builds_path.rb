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
      self.path = build_default_path
    end
  end

  def build_default_path
    self.class.name_to_path_element(name)
  end


  def included(base)
    base.extend(ClassMethods)
  end
end