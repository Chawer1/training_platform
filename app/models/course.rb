# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons

  validates :title, presence: true

  def owned_by?(user)
    self.user == user
  end
end
