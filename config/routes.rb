Vesta::Application.routes.draw do

  devise_for :users
  root "home#index"
  get "dashboard/index", as: "dashboard"

  resources :contractors
  resources :sub_contractors

end
