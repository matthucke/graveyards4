# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :klendathu, :class=>County do
    # state
    name "Klendathu"
    type_name 'County'
    path "Klendathu"
    full_path "Illinois/Klendathu"
    state { create(:illinois) }

    initialize_with {
      County.where(:name=>name).first_or_initialize
    }
  end

  factory :pangaea, :class=>County do
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
