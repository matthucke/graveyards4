# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    fore = Faker::Name.first_name
    aft = Faker::Name.last_name

    full_name "#{fore} #{aft}"
    email Faker::Internet.safe_email("#{fore} #{aft}")
    security_level 1

    after(:create) do |u, e|
      u.identities << Identity.new(provider: 'facebook', uid: rand(1000000))
    end
  end
end
