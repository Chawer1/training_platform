# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all courses to @courses' do
      course1 = create(:course)
      course2 = create(:course)
      get :index
      expect(assigns(:courses)).to match_array([course1, course2])
    end
  end

  describe 'GET #show' do
    let(:course) { create(:course) }

    it 'renders the show template' do
      get :show, params: { id: course.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested course to @course' do
      get :show, params: { id: course.id }
      expect(assigns(:course)).to eq(course)
    end
  end

  describe 'GET #new' do
    let(:user) { create(:teacher) }

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new course to @course' do
      get :new
      expect(assigns(:course)).to be_a_new(Course)
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:teacher) }
    let(:course) { create(:course, user: user) }

    it 'renders the edit template' do
      get :edit, params: { id: course.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested course to @course' do
      get :edit, params: { id: course.id }
      expect(assigns(:course)).to eq(course)
    end
  end

  describe 'POST #create' do
    let(:user) { create(:teacher) }

    context 'with valid attributes' do
      it 'creates a new course' do
        expect do
          post :create, params: { course: attributes_for(:course) }
        end.to change(Course, :count).by(1)
      end

      it 'redirects to the created course' do
        post :create, params: { course: attributes_for(:course) }
        expect(response).to redirect_to(course_path(assigns(:course)))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new course' do
        expect do
          post :create, params: { course: attributes_for(:course, title: '') }
        end.not_to change(Course, :count)
      end

      it 're-renders the new template' do
        post :create, params: { course: attributes_for(:course, title: '') }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:teacher) }
    let(:course) { create(:course, user: user) }

    context 'with valid attributes' do
      it 'updates the course' do
        patch :update, params: { id: course.id, course: { title: 'Course title' } }
        course.reload
        expect(course.title).to eq('Course title')
      end

      it 'redirects to the updated course' do
        patch :update, params: { id: course.id, course: { title: 'Course title' } }
        expect(response).to redirect_to(course_path(assigns(:course)))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the course' do
        patch :update, params: { id: course.id, course: { title: '' } }
        course.reload
        expect(course.title).not_to eq('')
      end

      it 're-renders the edit template' do
        patch :update, params: { id: course.id, course: { title: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:teacher) }
    let!(:course) { create(:course, user: user) }

    it 'destroys the course' do
      expect do
        delete :destroy, params: { id: course.id }
      end.to change(Course, :count).by(-1)
    end

    it 'redirects to courses#index' do
      delete :destroy, params: { id: course.id }
      expect(response).to redirect_to(courses_path)
    end
  end

  describe 'GET #my_courses' do
    context 'as a teacher' do
      let(:user) { create(:teacher) }

      before { sign_in(user) }

      it "assigns the teacher's courses to @courses" do
        get :my_courses

        expect(assigns(:courses)).to eq(user.courses)
      end

      it 'renders the my_courses template' do
        get :my_courses
        expect(response).to render_template(:my_courses)
      end
    end

    context 'as a student' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "assigns the student's courses to @courses" do
        course1 = create(:course)
        course2 = create(:course)
        create(:enrollment, user: user, course: course1)
        create(:enrollment, user: user, course: course2)

        get :my_courses

        expect(assigns(:courses)).to eq([course1, course2])
      end

      it 'renders the my_courses template' do
        get :my_courses
        expect(response).to render_template(:my_courses)
      end
    end
  end
end
