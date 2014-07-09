# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :graveyard do
    feature_type 1
    # county nil
    status 1
    name { "St. #{Faker::Name.first_name} Cemetery" }
    # path "MyString"
    lat { (39.0 + 3.0 * Random.rand) }
    lng { -(85.0 + 3.0 * Random.rand) }
    year_started 1850
    # usgs_id 1
    # usgs_map "MyString"
    # homepage "MyString"
  end
end
