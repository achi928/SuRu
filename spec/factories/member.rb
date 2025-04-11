FactoryBot.define do
  factory :member, aliases: [:owner] do

    nickname { Faker::Name.name }
    sequence(:email) { |n| "test#{n}@sample.com" }
    password { '111111' }
    password_confirmation { '111111' }
    
  end

  factory :blank_member, class: Member do
  end
end