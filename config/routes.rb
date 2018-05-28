Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :v1 do

    resources :users do
      get 'search', on: :collection
    end
    resources :posts
    resources :rewards do
      get 'my_rewards', on: :collection
    end
    resources :organizations
    resources :employments
    resources :contacts
    resources :acquire_rewards
  end

end
