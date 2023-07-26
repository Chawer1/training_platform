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
class Task < ApplicationRecord
  belongs_to :lesson
  has_many :submissions
  has_many :users, through: :submissions
  validates :name, presence: true
end
