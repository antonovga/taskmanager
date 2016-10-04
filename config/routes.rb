Rails.application.routes.draw do

  concern :taskable do
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

  scope module: :web do
    namespace :auth do
      resource :session, only: [:new, :create, :destroy]
    end

    resources :tasks, only: [:index]

    namespace :user do
      root 'tasks#index'

      concerns :taskable
    end
  end

  root 'web/tasks#index'
end
