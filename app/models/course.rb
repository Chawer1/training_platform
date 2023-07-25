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
class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons
  has_many :enrollments
  has_many :users, through: :enrollments

  validates :title, presence: true

  def owned_by?(user)
    self.user == user
  end
end
