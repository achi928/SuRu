FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.word }
    
    association :post 
  end
end
