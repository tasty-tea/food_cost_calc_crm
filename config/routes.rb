# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resources :fixed_costs
  resources :sellings
  resources :stock_units
  resources :products do
    resources :ingredients
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
