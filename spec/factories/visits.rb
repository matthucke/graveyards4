# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visit do
    user nil
    graveyard nil
    visited_on "2014-06-01 11:49:29"
    status 1
    notes "MyText"
  end
end
