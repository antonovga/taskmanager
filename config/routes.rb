Rails.application.routes.draw do
  scope module: :web do
    get 'pages/home'
  end

  root 'web/pages#home'
end
