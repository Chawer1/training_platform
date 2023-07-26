# frozen_string_literal: true

# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  task_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :task
end
