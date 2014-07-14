# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expedition do
    user nil
    name "MyString"
    started_on "2014-07-13"
    ended_on "2014-07-13"
    notes "MyText"
  end
end
