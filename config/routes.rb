Rails.application.routes.draw do

  if Rails.env.production?
    mount Shrine.presign_endpoint(:cache) => '/presign'
  end
  
  root 'static_pages#home'

  get 'privacy' => 'static_pages#privacy'
  get 'terms' => 'static_pages#terms'
  get 'about' => 'static_pages#about'

  get 'register' => 'static_pages#register'
  get 'sign-in' => 'static_pages#sign_in'

  devise_for :instructors, controllers: { sessions: "instructors/sessions", passwords: "instructors/passwords", registrations: "instructors/registrations", confirmations: "instructors/confirmations",  unlocks: "instructors/unlocks"}

  devise_scope :instructor do
    get 'sign_out', to: 'instructors/sessions#destroy'
  end

  devise_for :students, controllers: { sessions: "students/sessions", passwords: "students/passwords", registrations: "students/registrations", confirmations: "students/confirmations",  unlocks: "students/unlocks"}

  devise_scope :student do
    get 'sign_out', to: 'students/sessions#destroy'
  end

  resources :students, controller: 'students/students', only: :show do
    resource :profile, controller: 'profiles/profiles', only: :update
  end

  resources :instructors, controller: 'instructors/instructors', only: :show do
    resource :profile, controller: 'profiles/profiles', only: :update
    resources :courses, controller: 'instructors/courses' do 
      resources :reviews, controller: 'instructors/reviews', only: [:create, :update, :destroy]
      resources :tracks, controller: 'instructors/tracks' do
        resources :videos, controller: 'instructors/videos' do
          resources :comments, controller: 'instructors/comments', only: [:create, :update, :destroy]
        end
      end
    end
  end

  resources :categories, controller: 'categories/categories' do
    resources :subcategories, controller: 'categories/subcategories'
  end

end