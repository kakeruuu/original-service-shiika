Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'signup', to: 'users#new'
    resources :users, only: [:show, :new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
