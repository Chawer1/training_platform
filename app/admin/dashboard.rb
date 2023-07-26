# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end
  end

  # content do
  #   panel 'Recently Added Courses' do
  #     table_for Course.order(created_at: :desc).limit(5) do
  #       column :title
  #       column :description
  #       column :duration
  #       column :difficulty
  #       column :created_at
  #     end
  #   end
  # end

  content do
    panel 'Courses with Most Enrollments' do
      table_for Course.joins(:enrollments).group(:id).order('COUNT(enrollments.id) DESC').limit(5) do
        column :title
        column :difficulty
        column :duration
        column :enrollments_count do |course|
          course.enrollments.count
        end
        column :created_at
      end
    end
    para "Total Courses: #{Course.count}"
    para "Total Enrollments: #{Enrollment.count}"
    para "Total Users Enrolled: #{User.joins(:courses).distinct.count}"
  end
end
