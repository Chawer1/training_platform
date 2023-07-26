# frozen_string_literal: true

class CoursesController < ApplicationController
  include AuthorizationHelper
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :check_teacher_role, only: %i[new create edit update destroy]
  before_action :check_owner, only: %i[edit update destroy]
  protect_from_forgery

  def index
    @courses = Course.all
  end

  def show; end

  def new
    @course = Course.new
  end

  def edit; end

  def create
    @course = Course.new(course_params)
    @course.creator_id = current_user.id

    save_course
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_courses
    @courses = if current_user.teacher?
                 Course.where(creator_id: current_user.id)
               else
                 current_user.courses
               end
  end

  def enroll
    @course = Course.find(params[:id])
    current_user.enrollments.create(course: @course)

    redirect_to @course, notice: 'You have successfully enrolled in the course.'
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :duration, :difficulty,
                                   :price).merge(user_id: current_user.id)
  end

  def check_owner
    @course = Course.find(params[:id])

    return if @course.owned_by?(current_user)

    redirect_to root_path, alert: "You can't edit a course that doesn't belong to you."
  end

  def save_course
    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end
end
