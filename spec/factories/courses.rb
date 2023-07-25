# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  duration    :integer
#  difficulty  :string
#  price       :decimal(, )
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#
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
