Rails.application.routes.draw do
  root "home#index"
  resource :users, only: %i(edit new create destroy)

  namespace :api do
    namespace :v1 do
    end
  end
end
