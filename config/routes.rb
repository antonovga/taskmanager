Rails.application.routes.draw do
  scope module: :web do
    namespace :auth do
      resources :sessions, only: [:new, :create]
      delete 'sessions/destroy'
    end
    resources :tasks, except: [:show]
  end

  root 'web/users/tasks#index'
end
