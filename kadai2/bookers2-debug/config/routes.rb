Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  root 'home#top' 
  get 'home/about'
end