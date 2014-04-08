Webserver::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  get 'submission' => 'submissions#new'
  post 'submission' => 'submissions#create'
end
