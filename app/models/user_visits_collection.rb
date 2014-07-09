class UserVisitsCollection
  attr_accessor :user

  def initialize(user)
    @user=user
    @visits=nil # will lazy-load
    @graveyard_ids=[]
  end

  def add_graveyards list
    @graveyard_ids += list.map(&:id)
    @visits=nil # clear, will have to reload.
  end

  def visits
    @visits ||= map_visits(find_visits)
  end

  def visited?(graveyard)
    !!visit_for(graveyard)
  end

  def visit_for(graveyard)
    visits[graveyard.id]
  end

  def map_visits visit_list
    visit_list.each_with_object({}) do |v, hash|
      hash[v.graveyard_id] = v
    end
  end

  def find_visits
    return [] unless user
    return [] if @graveyard_ids.empty?

    user.visits.where(
        :graveyard_id => @graveyard_ids
    )
  end

end