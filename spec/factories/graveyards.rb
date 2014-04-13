# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :graveyard do
    feature_type 1
    county nil
    status 1
    name "MyString"
    path "MyString"
    lat "9.99"
    lng "9.99"
    year_started 1
    usgs_id 1
    usgs_map "MyString"
    homepage "MyString"
  end
end
