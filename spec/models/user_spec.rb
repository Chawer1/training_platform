# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  role                   :integer          default("user")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#enrolled_in?' do
    let(:user) { create(:user) }
    let(:course) { create(:course) }

    context 'when user is not enrolled in the course' do
      it 'returns false' do
        expect(user.enrolled_in?(course)).to be_falsey
      end
    end

    context 'when user is enrolled in the course' do
      before { user.enrollments.create(course: course) }

      it 'returns true' do
        expect(user.enrolled_in?(course)).to be_truthy
      end
    end
  end
end
