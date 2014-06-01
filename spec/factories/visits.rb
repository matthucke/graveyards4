# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visit do
    user nil
    graveyard nil
    visited_at "2014-06-01 11:49:29"
    visit_type 1
    notes "MyText"
  end
end
