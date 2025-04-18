FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "test#{n}@sample.com" }
    password { '111111' }
    password_confirmation { '111111' }
    
  end
end