Rails.application.routes.draw do
  
  root 'static_pages#home'

  get 'privacy' => 'static_pages#privacy'
  get 'terms' => 'static_pages#terms'
  get 'about' => 'static_pages#about'

  devise_for :instructors, controllers: { sessions: "instructors/sessions", passwords: "instructors/passwords", registrations: "instructors/registrations", confirmations: "instructors/confirmations",  unlocks: "instructors/unlocks"}

  devise_scope :instructor do
    get 'sign_out', to: 'instructors/sessions#destroy'
    get 'sign_in', to: 'instructors/sessions#new'
    get 'register', to: 'instructors/registrations#new'
  end

  devise_for :students, controllers: { sessions: "students/sessions", passwords: "students/passwords", registrations: "students/registrations", confirmations: "students/confirmations",  unlocks: "students/unlocks"}

  devise_scope :student do
    get 'sign_out', to: 'students/sessions#destroy'
    get 'sign_in', to: 'students/sessions#new'
    get 'register', to: 'students/registrations#new'
  end

  resources :instructors, controller: 'instructors/instructors', only: :show
  resources :students, controller: 'students/students', only: :show

end