# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favourite, :class => 'Favourites' do
    book_id 1
    user_id 1
  end
end
