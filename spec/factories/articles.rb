# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    status 1
    section 1
    graveyard nil
    author nil
    headline "MyString"
    path "MyString"
    published_at "2014-07-12 19:04:19"
    teaser "MyText"
    body "MyText"
  end
end
