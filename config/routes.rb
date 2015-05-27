Rails.application.routes.draw do
  root :to => 'examples#index'

  resources :examples

  get :reset, :to => 'examples#reset'

end
