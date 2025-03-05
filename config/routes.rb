Rails.application.routes.draw do

  scope module: :member do
    devise_for :members, skip: :password, controllers: {
      registrations: 'member/registrations',
      sessions: 'member/sessions'
    }
    root 'homes#top'
    get "/about" => "homes#about", as: "about"
    resources :calendars, only: [:index]
    resources :memberships, only: [:create, :destroy]

    resources :group_posts, only: [:new, :create, :show, :index, :edit, :update] do
      resources :likes, only: [:create]
      resources :comments, only: [:create, :index, :edit, :update]
    end
    resources :groups, only: [:new, :create, :show, :edit, :update, :destroy]
    get 'groups_search', to: 'groups#search'

    resources :categories, only: [:index]
    get 'categories/:id/groups', to: 'categories#groups'

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
    get 'members/search', to: 'members#search'
    resources :members, only: [:show, :update] do
      resources :comments, only: [:index, :destroy]
    end
    resources :categories, only: [:new, :create, :index, :edit, :update, :destroy]
    resources :groups, only: [:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
