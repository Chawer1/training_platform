# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  course_id       :integer          not null
#  enrollment_date :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :enrollment do
    association :user
    association :course
    enrollment_date { Time.now }
  end
end
