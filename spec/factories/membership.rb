FactoryBot.define do
  factory :membership do
    
    association :member
    association :group
    is_active { true }

  end
end