Rails.application.routes.draw do

  if Rails.env.production?
    mount Shrine.presign_endpoint(:cache) => '/presign'
  end
  
  root 'static_pages#home'

  get 'privacy' => 'static_pages#privacy'
  get 'terms' => 'static_pages#terms'
  get 'about' => 'static_pages#about'
  get 'faq' => 'static_pages#faq'
  get 'updates' => 'static_pages#updates'

  get 'search' => 'instructors/courses#search'

  get 'register' => 'static_pages#register'
  get 'sign-in' => 'static_pages#sign_in'

  devise_for :instructors, controllers: { sessions: "instructors/sessions", passwords: "instructors/passwords", registrations: "instructors/registrations", confirmations: "instructors/confirmations",  unlocks: "instructors/unlocks"}

  devise_scope :instructor do
    get 'sign_out', to: 'instructors/sessions#destroy', path: 'sign-out'
    get 'instructor_edit_plan', to: 'instructors/registrations#edit_plan', path: 'instructors/:id/edit-plan'
    patch 'instructor_update_plan', to: 'instructors/registrations#update_plan', path: 'instructors/:id/update-plan'
  end

  devise_for :students, controllers: { sessions: "students/sessions", passwords: "students/passwords", registrations: "students/registrations", confirmations: "students/confirmations",  unlocks: "students/unlocks"}

  devise_scope :student do
    get 'sign_out', to: 'students/sessions#destroy'
    get 'student_edit_source', to: 'students/registrations#edit_source', path: 'students/:id/edit-source'
    patch 'student_update_source', to: 'students/registrations#update_source', path: 'students/:id/update-source'
  end

  resources :students, controller: 'students/students', only: :show do
    resource :profile, controller: 'profiles/profiles', only: :update
  end

  resources :instructors, controller: 'instructors/instructors', only: :show do
    resource :profile, controller: 'profiles/profiles', only: :update
    resource :merchant, controller: 'instructors/merchants', only: [:new, :create, :edit, :update]
    resources :posts, controller: 'instructors/posts', only: [:show, :create, :update, :destroy]
    resources :courses, controller: 'instructors/courses', only: [:show, :create, :update, :destroy] do
      resources :bookmarks, controller: 'students/bookmarks', only: [:create, :destroy]
      resources :reviews, controller: 'instructors/reviews', only: [:create, :update, :destroy]
      resources :tracks, controller: 'instructors/tracks', only: [:create, :update, :destroy] do
        resources :videos, controller: 'instructors/videos', only: [:show, :create, :update, :destroy] do
          resources :comments, controller: 'instructors/comments', only: [:create, :update, :destroy]
        end
      end
      resources :purchases, path: 'purchases', controller: 'purchases/purchases', only: [:create, :destroy] do
        member do
          get 'checkout'
          patch 'charge'
        end
        resources :refunds, controller: 'purchases/refunds', only: :create
      end
    end
    resources :subscriptions, controller: 'instructors/subscriptions', only: [:create, :destroy]
  end

  resources :categories, controller: 'categories/categories' do
    resources :subcategories, controller: 'categories/subcategories', except: :index
  end

end