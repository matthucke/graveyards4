# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :illinois, :class=>'State' do
    state_code "IL"
    country_code "US"
    name "Illinois"

    initialize_with {
      State.where(:name=>name, :country_code=>country_code).first_or_initialize
    }
  end
end
