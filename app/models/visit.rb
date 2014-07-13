class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :graveyard

  delegate :county, :county_id, :name, :state_id, :state, to: :graveyard

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
end
