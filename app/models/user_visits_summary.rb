class UserVisitsSummary
  attr_accessor :user

  def initialize(user)
    @user=user
  end

  def summary
    return {} unless user && user.id
    @summary ||= build_summary!
  end

  def get county_id
    summary[county_id.to_i] ||= OpenStruct.new
  end

  def build_summary!
    s = load_rows.inject({}) do |hash, row|
      cid = row.county_id.to_i
      hash[cid] ||= OpenStruct.new
      hash[cid].send("#{row.status}=", row.count.to_i)
      hash
    end
  end

  def load_rows
    return [] unless user && user.id

    Visit.connection.select_all(
        count_query.to_sql
    ).map { |r| OpenStruct.new(r) }
  end

  # u=User.find 1
  # reload!; s=UserVisitsSummary.new(u); puts s.count_query.to_sql
  def count_query
    v = Visit.table_name
    Visit.select(
        "county_id, #{v}.status, count(#{v}.id) as count"
    ).joins(:graveyard).group("county_id, #{v}.status").where(
        user_id: user.id
    )
  end
end


