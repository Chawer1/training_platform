# frozen_string_literal: true

# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  course_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :lesson do
    title { 'Lesson Title' }
    description { 'Lesson description' }
    association :course
  end
end
