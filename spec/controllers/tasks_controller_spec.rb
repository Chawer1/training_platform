# frozen_string_literal: true

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:teacher) }
  let(:course) { create(:course) }
  let(:lesson) { create(:lesson, course: course) }
  let(:task) { create(:task, lesson: lesson) }
  before { sign_in(user) }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { course_id: course.id, lesson_id: lesson.id }
      expect(response).to render_template(:new)
    end

    it 'assigns a new task to @task' do
      get :new, params: { course_id: course.id, lesson_id: lesson.id }
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new task' do
        expect do
          post :create, params: { course_id: lesson.course.id, lesson_id: lesson.id, task: attributes_for(:task) }
        end.to change(Task, :count).by(1)
      end

      it "redirects to the lesson's page" do
        post :create, params: { course_id: lesson.course.id, lesson_id: lesson.id, task: attributes_for(:task) }
        expect(response).to redirect_to(course_lesson_path(lesson.course, lesson))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new task' do
        expect do
          post :create,
               params: { course_id: lesson.course.id, lesson_id: lesson.id, task: attributes_for(:task, name: nil) }
        end.not_to change(Task, :count)
      end

      it "re-renders the 'new' template" do
        post :create,
             params: { course_id: lesson.course.id, lesson_id: lesson.id, task: attributes_for(:task, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { course_id: course.id, lesson_id: lesson.id, id: task.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested task to @task' do
      get :show, params: { course_id: course.id, lesson_id: lesson.id, id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { course_id: course.id, lesson_id: lesson.id, id: task.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested task to @task' do
      get :edit, params: { course_id: course.id, lesson_id: lesson.id, id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:updated_name) { 'Updated Task Name' }

      it 'updates the task' do
        patch :update, params: { course_id: course.id, lesson_id: lesson.id, id: task.id, task: { name: updated_name } }
        task.reload
        expect(task.name).to eq(updated_name)
      end

      it 'redirects to the task show page' do
        patch :update, params: { course_id: course.id, lesson_id: lesson.id, id: task.id, task: { name: updated_name } }
        expect(response).to redirect_to(course_lesson_task_path(course, lesson, task))
      end

      it 'sets a flash notice' do
        patch :update, params: { course_id: course.id, lesson_id: lesson.id, id: task.id, task: { name: updated_name } }
        expect(flash[:notice]).to eq('Задание успешно обновлено.')
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        patch :update, params: { course_id: course.id, lesson_id: lesson.id, id: task.id, task: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end
end
