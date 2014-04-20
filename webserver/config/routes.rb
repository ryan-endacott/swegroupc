Webserver::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :submissions

  resources :courses do
    resources :assignments, except: [:index]
  end
end
