Vesta::Application.routes.draw do
  get "tasks/create"
  get "tasks/update"
  root "home#index"
  devise_for :users

  resources :contractors do
    resources :users
  end

  resources :sub_contractors do
    resources :users
  end

  resources :projects do
    resources :activities do
      resource :execution, only: :create
      resource :task, only: [:create, :update]
      resources :images, except: :show, controller: 'activities/images'
    end

    resources :collaborators, except: :show
  end

  get "dashboard", to: "dashboard#index"

end
