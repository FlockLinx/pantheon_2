require 'sidekiq/web'
require 'sidecloq/web'

Rails.application.routes.draw do
  apipie
  mount_devise_token_auth_for 'User', at: 'auth'
  mount Sidekiq::Web => '/sidekiq'

  namespace :v1 do
    resources :users do
      get 'search', on: :collection
    end
    resources :rewards do
      get 'my_rewards', on: :collection
    end
    resources :organizations do
      get 'employees_list', on: :collection
      get 'star_ranking', on: :collection
    end
    resources :posts
    resources :employments
    resources :contacts
    resources :acquire_rewards
  end

end
