Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboards#index"
  get '/search', to: "dashboards#search"
  resources :users do
    resources :exercises
  end
end
