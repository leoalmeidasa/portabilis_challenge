Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :users  do
        post 'search', to: 'users#search', as: 'search', on: :collection
        member do
          patch :inactivate
        end
      end
    end
  end
end
