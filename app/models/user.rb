# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: %i[user teacher admin]
  after_initialize :set_default_role, if: :new_record?

  has_many :enrollments
  has_many :courses, through: :enrollments
  def set_default_role
    self.role ||= :user
  end

  def enrolled_in?(course)
    enrollments.exists?(course: course)
  end
end
