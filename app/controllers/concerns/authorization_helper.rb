# frozen_string_literal: true

module AuthorizationHelper
  private

  def check_teacher_role
    redirect_to root_path, alert: 'No access' unless current_user.teacher?
  end
end
