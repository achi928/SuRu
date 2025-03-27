require 'rails_helper'

FactoryBot.define do
  factory :member do

    nickname { Faker::Name.name }
    gender { :unspecified }
    sequence(:email) { |n| "test#{n}@sample.com" }
    password { 'password' }
    password_confirmation { 'password' }
    
  end
end