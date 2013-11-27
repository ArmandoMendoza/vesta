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
      resources :images, except: :show, controller: 'activities/images'
    end

    resources :collaborators, except: :show
  end

  get "dashboard", to: "dashboard#index"

end
