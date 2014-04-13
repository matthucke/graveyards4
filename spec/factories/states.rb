# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :state do
    state_code "MyString"
    country_code "MyString"
    name "MyString"
    path "MyString"
  end
end
