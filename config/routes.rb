Rails.application.routes.draw do
  scope module: :web do
    namespace :auth do
      resources :sessions, only: [:new, :create]
      delete 'sessions/destroy'
    end
    get 'pages/home'
  end

  root 'web/pages#home'
end
