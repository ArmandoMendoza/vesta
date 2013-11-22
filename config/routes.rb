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
    resources :activities
    resources :collaborators, except: :show
  end

  get "dashboard", to: "dashboard#index"

end
