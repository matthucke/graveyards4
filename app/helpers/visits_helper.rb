module VisitsHelper

  # Return a hash of lists.
  def group_by_county(visits)
    # hash first...
    groups = visits.group_by(&:county_id)

    # then sort.
    sub_lists = groups.values.sort_by do |group|
      with_county = group.find(&:county)
      with_county ? with_county.county.name : ""
    end

    # take the sorted sub-lists and make a new hash.
    sub_lists.inject({}) do |hash, group|
      county = group.find(&:county).county rescue nil
      hash[county] = group.sort_by(&:name)
      hash
    end
  end
end
