# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :featured_site do
    section "MyString"
    graveyard nil
    url "MyString"
    headline "MyString"
    description "MyText"
  end
end
