Rails.application.routes.draw do
  root "home#index"
  resource :users, only: %i(edit new create destroy)
end
