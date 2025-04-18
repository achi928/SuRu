FactoryBot.define do
  factory :membership do
    is_active { true }

    association :member
    association :group
  end
end