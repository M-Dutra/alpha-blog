Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  #Rest-ful routes to Rails resources
  #HTTP verbs - Get, Post, Put, Patch, Delete
  resources :articles
end
