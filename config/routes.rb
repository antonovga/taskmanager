Rails.application.routes.draw do
  scope module: :web do
    namespace :auth do
      resource :session, only: [:new, :create, :destroy]
    end
    resources :tasks, except: [:show]
  end

  root 'web/tasks#index'
end
