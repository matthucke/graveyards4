# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :county do
    state nil
    name "MyString"
    county_type 1
    path "MyString"
    full_path "MyString"
  end
end
