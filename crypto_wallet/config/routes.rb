Rails.application.routes.draw do
  resources :mining_types
  get 'welcome/index'
  get 'inicio', to: 'welcome#index'
  
  resources :coins

  root 'welcome#index'
end
