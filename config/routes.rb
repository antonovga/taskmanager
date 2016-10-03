Rails.application.routes.draw do
  scope module: :web do
    namespace :auth do
      resource :session, only: [:new, :create, :destroy]
    end
    resources :tasks do
      member do
        patch 'start'
        patch 'finish'
      end
      scope module: :tasks do
        resource :attachment, only: []do
          get 'download'
        end
      end
    end
  end

  root 'web/tasks#index'
end
