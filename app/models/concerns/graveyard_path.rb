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

  # Validator
  def path_must_be_unique_in_county
    return nil if path.blank? || !county

    my_path = self.path.to_s.downcase
    others = county.graveyards.select do |g|
      (g.path.to_s.downcase == my_path) && (g.id != self.id)
    end

    others.each do |o|
      next if o.id==self.id
      errors.add(:path, "#{self.path} has already been taken")
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end