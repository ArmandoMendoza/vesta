Vesta::Application.routes.draw do
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
      resources :tasks, only: [:create, :update, :destroy] do
        patch :mark, on: :member
      end
      resources :images, except: :show, controller: 'activities/images'
      resources :comments, only: [:create, :destroy], controller: 'activities/comments'
    end

    resources :collaborators, except: :show
  end

  get "dashboard", to: "dashboard#index"

end
