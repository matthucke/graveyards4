# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :county do
    # Faker doesn't do county names, so let's just take one word from a city name.
    name Faker::Address.city.split(/ /).last

    state { create(:illinois) }
    type_name 'County'
  end

  factory :valid_county, parent: :county do
    initialize_with {
      County.new(attributes).tap { |c| c.valid? }
    }
  end

  factory :klendathu, class: County, parent: :county do
    # state
    name "Klendathu"
    path "Klendathu"
    full_path "Illinois/Klendathu"
    state { create(:illinois) }

    initialize_with {
      County.where(:name=>name).first_or_initialize
    }
  end

  factory :pangaea, parent: :county do
    # state
    name "Pangaea"
    type_name 'County'
    path "Pangaea"

    state { create(:illinois) }

    initialize_with {
      County.where(:name=>name).first_or_initialize
    }
  end

end
