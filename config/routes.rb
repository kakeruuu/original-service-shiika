Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'about', to: 'staticspages#about'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    post 'guest', to: 'guest_sessions#create'
    
    get 'signup', to: 'users#new'
    resources :users, only: [:show, :new, :create, :edit, :update] do
        member do 
            get :likes
        end
    end
    
    get 'post/tag/:name', to: 'posts#tag'
    get 'posts', to: 'posts#new'
    resources :posts, only: [:new, :create, :destroy]
    
    resources :favorites, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
