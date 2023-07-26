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
require 'rails_helper'

RSpec.describe Submission, type: :model do
  describe 'associations' do
    it { should respond_to(:user) }
    it { should respond_to(:task) }
  end

  it 'has a valid factory' do
    submission = FactoryBot.build(:submission)
    expect(submission).to be_valid
  end
end
