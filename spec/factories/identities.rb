# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    user nil
    uid "MyString"
    provider "MyString"
    provider "MyText"
    text "MyString"
  end
end
