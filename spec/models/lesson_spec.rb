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
require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it 'has a valid factory' do
    lesson = FactoryBot.build(:lesson)
    expect(lesson).to be_valid
  end

  describe 'validations' do
    it { should respond_to(:course) }
  end

  describe 'associations' do
    it 'belongs to a course' do
      expect(Lesson.new).to respond_to(:course)
    end
  end
end
