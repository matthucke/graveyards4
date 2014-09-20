require 'spec_helper'

describe Graveyard do
  context "a new graveyard" do
    subject(:g) { Graveyard.new }

    it "wants name" do
      expect(g.errors_on(:name)).to_not be_empty
    end
    it "wants county" do
      expect(g.errors_on(:county)).to_not be_empty
    end
    it "wants path" do
      expect(g.errors_on(:path)).to_not be_empty
    end
  end

  context "with name and county" do
    before {
      @county = create(:klendathu, :state=>create(:illinois))
    }
    subject(:g) { Graveyard.new(:county=>@county, :name=>"St. John's Cemetery")}

    it "constructs path" do
      expect(g.default_path).to be == "St-Johns-Cemetery"
    end

    it "sets full path" do
      g.path = g.default_path
      expect(g.full_path).to be == g.default_full_path
      expect(g.full_path).to match /Klendathu/
    end
  end

  context "there can be only one" do
    before {
      @county = create(:klendathu, :state=>create(:illinois))
      @adversary = Graveyard.create!(:name=>"St. John's Cemetery", :county=>@county)
      @county.graveyards << @adversary
    }

    subject(:g) {
      Graveyard.new(:name=>"St. John's Cemetery", :county=>@county)
    }

    it "complains about path collision" do
      expect(g.county).to_not be_nil
      expect(g).to_not be_valid
      expect(g.errors_on(:path)).to_not be_empty

      expect(g.errors_on(:path).to_s).to match("already been taken")
    end
  end


end


=begin
migrating old data:


insert into graveyards
select id, 0 as feature_type, county_id, status,
  name, url as path, latitude as lat, longitude as lng,
  yearstarted, usgsid, usgsmap, homepage, now(), now()
  from graveyards_com.graveyards;

-- confirm visually that the data is what we think it is
select * from graveyards where county_id=149;   -- Cook
select path,lat,lng from graveyards where county_id=149 order by lat;
select name,lat,lng from graveyards where county_id=220 order by lat; -- St Clair

update graveyards set lng=null where lng between -0.001 and 0.001;
update graveyards set lat=null where lat between -0.001 and 0.001;
update graveyards set year_started=null where year_started < 1;
update graveyards set status=null where status < 1;
update graveyards set usgs_id=null where usgs_id=0;
update graveyards set usgs_map=null where usgs_map rlike '^!';

# fix paths
Graveyard.find_each do |g|
  next if g.path.blank?

  g.path = g.path.to_s.gsub(%r#.*/#, '')
  g.path = g.path.gsub('_', '-')
  g.save if g.changed? && !g.path.blank?
  puts g.path
end


=end