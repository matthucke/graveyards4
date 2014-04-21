module GraveyardPath
  include ActiveSupport::Concern
  include BuildsPath

  module ClassMethods
    # overrides BuildsPath
    def name_to_path_element(n)
      # invoke BuildsPath::ClassMethods.name_to_path_element
      super(n.to_s.gsub(/Cemetery$/i, ''))
    end
  end

  # Validation - uniqueness of path, constrained by county.
  def path_must_be_unique_in_county
    return nil if path.blank? || !county

    my_path = self.path.to_s.downcase
    county.graveyards.each do |g|
      if (g.path.to_s.downcase == my_path) && (g.id != self.id)
        errors.add(:path, "#{self.path} has already been taken")
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end