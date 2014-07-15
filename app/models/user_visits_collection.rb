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
    id = graveyard.is_a?(Fixnum) ? graveyard : graveyard.id
    visits[id]
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

  def as_json(*args)
    find_visits.inject({}) do |h, v|
      h[v.graveyard_id] = v.as_json(:only=> [
          :id, :status, :visited_on,
          :expedition_id, :ordinal, :quality
      ])
      # h[v.graveyard_id] = v.as_json
      h
    end
  end

end