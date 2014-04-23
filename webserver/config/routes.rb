Webserver::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :submissions, except: [:show, :edit, :update, :destroy]

  resources :courses do
    member do
      post 'create_section'
      delete 'delete_section/:section_id', to: 'courses#delete_section', as: 'delete_section'
      post 'add_ta'
      delete 'remove_ta/:ta_id', to: 'courses#remove_ta', as: 'remove_ta'
    end
    resources :assignments, except: [:index]
  end
end
