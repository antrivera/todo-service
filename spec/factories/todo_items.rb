require 'faker'

FactoryGirl.define do
  factory :todo_item do
    title Faker::Hipster.sentence
  end

end
