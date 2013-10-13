Vesta::Application.routes.draw do

  devise_for :users
  root "home#index"
  get "dashboard/index", as: "dashboard"

  resources :contractors do
    resources :users
  end

  resources :sub_contractors do
    resources :users
  end
end
