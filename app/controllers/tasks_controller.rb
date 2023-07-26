# frozen_string_literal: true

class TasksController < ApplicationController
  include AuthorizationHelper
  before_action :set_course
  before_action :set_lesson
  before_action :set_task, only: %i[show edit update destroy]
  before_action :check_teacher_role, only: %i[new create edit update destroy]

  def new
    @task = Task.new
  end

  def create
    @task = @lesson.tasks.build(task_params)

    if @task.save
      redirect_to course_lesson_path(@lesson.course, @lesson), notice: 'Задание успешно создано.'
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    if @task.update(task_params)
      redirect_to course_lesson_task_path(@course, @lesson, @task), notice: 'Задание успешно обновлено.'
    else
      render :edit
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :materials, :status)
  end
end
