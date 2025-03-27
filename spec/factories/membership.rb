require 'rails_helper'

FactoryBot.define do
  factory :membership do

    association :member
    association :group

  end
end