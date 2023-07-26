# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123321' }
    role { 0 }

    factory :teacher do
      role { 1 }
    end
  end
end
