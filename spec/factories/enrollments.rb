# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment do
    association :user
    association :course
    enrollment_date { Time.now }
  end
end
