Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  root 'pages#home'

  resources :courses do
    resources :lessons

    member do
      post 'enroll', to: 'courses#enroll'
    end
  end

  get "my_courses", to: "courses#my_courses"
end
