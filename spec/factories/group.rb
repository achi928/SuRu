require 'rails_helper'

FactoryBot.define do
  factory :group do
    name { Faker::Name.name }
    introduction { Faker::Lorem.sentence }

    association :owner, factory: :member
    association :category 
    
  end
end