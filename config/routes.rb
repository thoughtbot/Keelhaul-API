Rails.application.routes.draw do
  namespace :admin do
    resources :receipts
    resources :users

    root to: "receipts#index"
  end

  root "users#new"
  resource :users, only: %i(edit new create destroy)

  namespace :api do
    namespace :v1 do
      resources :verifications, only: [:create]
    end
  end
end
