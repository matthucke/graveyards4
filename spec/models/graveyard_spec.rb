require 'spec_helper'

describe Graveyard do
  pending "add some examples to (or delete) #{__FILE__}"
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
Graveyard.all.map { |p| p.path = p.path.gsub(%r#.*/#, ''); puts p.path }
=end