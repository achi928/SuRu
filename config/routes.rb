Rails.application.routes.draw do

  scope module: :member do
    devise_for :members, skip: [:password, :registrations, :sessions]
  
    devise_scope :member do
      get '/members/sign_up', to: 'registrations#new', as: 'new_member_registration'
      post '/members', to: 'registrations#create', as: 'member_registration'
      get '/members/sign_in', to: 'sessions#new', as: 'new_member_session'
      post '/members/sign_in', to: 'sessions#create', as: 'member_session'
      delete '/members/sign_out', to: 'sessions#destroy', as: 'destroy_member_session'
    end  
  
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    resources :calendars, only: [:index]
    get 'groups/search', to: 'groups#search'
    get 'groups/:id/infomation', to: 'groups#infomation', as: 'infomation'

    resources :groups, only: [:new, :create, :show, :edit, :update, :destroy, ] do
      resources :posts, only: [:create, :show, :edit, :update]
      resources :memberships, only: [:create]
      patch 'membership/:id/withdraw', to: 'memberships#withdraw', as: 'withdraw_membership'
    end
    
    resources :posts, only: [] do
      resources :comments, only: [:new, :create, :index, :edit, :update]
      resources :likes, only: [:create]
    end
    
    resources :categories, only: [:index]
    get 'categories/:id/groups', to: 'categories#groups', as: 'category_groups'

    resources :members, only: [:show]
    get 'mypage', to: 'members#mypage'
    get 'profile/edit', to: 'members#edit'
    patch 'profile', to: 'members#update'
    get 'unsubscribe', to: 'members#unsubscribe'
    patch 'withdraw', to: 'members#withdraw'
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    root to: 'homes#top'
    patch 'withdraw/:id', to: 'members#withdraw', as: 'withdraw'
    get 'members/search', to: 'members#search'
    resources :members, only: [:show] do
      resources :comments, only: [:index, :destroy]
    end
    resources :categories, only: [:new, :create, :index, :edit, :update, :destroy]
    resources :groups, only: [:index, :show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
