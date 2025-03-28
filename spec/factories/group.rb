require 'rails_helper'

FactoryBot.define do
  factory :group do
    name { Faker::Lorem.sentence }
    introduction { Faker::Lorem.sentence }

    association :owner
    association :category 
    
  end
end