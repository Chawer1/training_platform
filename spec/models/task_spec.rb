# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  name         :string
#  description  :text
#  materials    :string
#  date_created :datetime
#  status       :string
#  lesson_id    :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'has a valid factory' do
    task = FactoryBot.build(:task)
    expect(task).to be_valid
  end

  describe 'validations' do
    it { should respond_to(:lesson) }
  end

  describe 'associations' do
    it 'belongs to a course' do
      expect(Task.new).to respond_to(:lesson)
    end
  end
end
