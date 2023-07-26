# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    title { 'Lesson Title' }
    description { 'Lesson description' }
    association :course
  end
end
