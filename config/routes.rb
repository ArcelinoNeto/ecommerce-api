Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'

  namespace :admin do
    namespace :v1 do
      get "home" => "home#index"
      resources :categories
      resources :products
      resources :orders, only: %i[index show update]
    end
  end

  namespace :storefront do
    namespace :v1 do
      resources :categories, only: %i[index show]
      resources :products, only: %i[index show]
      resources :orders, only: %i[index show create]
    end
  end
end
