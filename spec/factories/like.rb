FactoryBot.define do
  factory :like do

    association :member
    association :post 

  end
end