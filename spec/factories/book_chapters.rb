# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book_chapter do
    qr_code "MyString"
    section_id 1
    sort_order 1
    graveyard nil
    title "MyString"
    main_content "MyText"
  end
end
