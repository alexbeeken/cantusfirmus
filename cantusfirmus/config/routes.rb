Rails.application.routes.draw do
  root :to => 'examples#index'

  resources :examples

end
