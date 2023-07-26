# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show edit update destroy]
  before_action :check_teacher_role, only: %i[new create edit update destroy]

  def show
    @course = @lesson.course
  end

  def new
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build
  end

  def create
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build(lesson_params)

    if @lesson.save
      redirect_to course_path(@course), notice: 'The lesson has been successfully created.'
    else
      render :new
    end
  end

  def edit
    @course = @lesson.course
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to course_lesson_path(@lesson), notice: 'The lesson has been successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy

    redirect_to courses_url, notice: 'The lesson has been successfully deleted.'
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description, :course_id)
  end

  def check_teacher_role
    redirect_to root_path, alert: 'No access' unless current_user.teacher?
  end
end
