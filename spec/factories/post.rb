FactoryBot.define do
  factory :post do

    content { Faker::Lorem.sentence }
    
    association :member
    association :group 

  end
end