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
require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'has a valid factory' do
    course = FactoryBot.build(:course)
    expect(course).to be_valid
  end

  describe 'validators' do
    it 'should ensure the presence of user' do
      course = FactoryBot.build(:course, user: nil)
      expect(course).not_to be_valid
      expect(course.errors[:user]).to be_present
    end
  end

  describe 'associations' do
    it 'should belong to a user' do
      user = FactoryBot.create(:teacher)
      course = FactoryBot.build(:course, user: user)
      expect(course.user).to eq user
    end

    it 'should allow multiple lessons' do
      course = FactoryBot.create(:course)

      3.times.each do |n|
        lesson = FactoryBot.create(:lesson)
        course.lessons << lesson
        course_lessons = course.lessons
        expect(course_lessons.count).to eq n.next
        expect(course_lessons).to include lesson
      end
    end
  end

  describe 'Graceful Destruction' do
    it 'should destroy the associated lessons when deleted' do
      course = FactoryBot.create(:course)
      course.lessons.create(FactoryBot.attributes_for(:lesson))

      expect { course.destroy }.to change(Lesson, :count).by(-1)
    end
  end
end
