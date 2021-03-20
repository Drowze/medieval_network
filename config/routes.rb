Rails.application.routes.draw do
  resources :wizards, only: [:create]
end
