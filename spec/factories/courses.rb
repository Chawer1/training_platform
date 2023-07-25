# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { 'Course title' }
    description { 'Course description' }
    duration { 5 }
    difficulty { 'Intermediate' }
    price { 100 }
    user
  end
end
