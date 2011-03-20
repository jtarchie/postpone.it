Postponeit::Application.routes.draw do


  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}

  resources :accounts, :only => [:index]
  resources :videos, :only => [:index, :new, :edit, :create, :update, :destroy]

  root :to => "home#show"
end
