Ticketee::Application.routes.draw do
  devise_for :users

  resources :projects do
    resources :tickets
  end

  root :to => "projects#index"

  namespace :admin do
    root :to => "base#index"
    resources :users
  end
end
