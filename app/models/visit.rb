class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :expedition, :counter_cache=>true
  belongs_to :graveyard

  delegate :county, :county_id, :name, :state_id, :state, to: :graveyard

  before_validation :populate_ordinal

  VISITED='visited'
  TODO='todo'

  STATUS_OPTIONS = {
      VISITED => 'Visited This Place',
      TODO => 'On Your To-Do List'
  }

  VISIBILITY_OPTIONS = {
    1000 => 'Public - Everyone can see this',
    0 => 'Private - Only you can see this'
  }

  def todo?
    status == TODO
  end

  def visited?
    status == VISITED
  end

  # status, nounified
  def what
    todo? ? 'todo' : 'visit'
  end

  # A very brief description for link tooltip text
  def caption
    if status == TODO
      "This is on your To-Do List"
    elsif status == VISITED
      text = "You visited this location"
      text += visited_on ? " on #{visited_on.to_s(:sql)}." : "."
    else
      "unknown status #{status}"
    end
  end

  def visible_to?(user)
    return false unless user

    (user.id == self.user_id) || (user.admin?)
  end

  def populate_ordinal
    if self.visited? && ! self.ordinal && self.user
      max = self.user.visits.visited_with_quality.select('max(ordinal) as ordinal').map(&:ordinal).last.to_i
      count = self.user.visits.visited_with_quality.count

      return self.ordinal = 1 + ((max > count) ? max : count)
    end
    true
  end

  def self.visited_with_quality
    where(:status=> 'visited').where("quality >= 8")
  end

  def self.for_user(u)
    where(user_id: u.id).includes(graveyard: :county)
  end
end
