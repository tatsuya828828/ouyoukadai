Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
  	resource :post_comments, only: [:create] do
  		delete '/books/:book_id/post_comments/:id' => 'post_comments#destroy', as: 'destroy_comment'
  	end
  	resource :favorites, only: [:create, :destroy]
  end
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  root 'home#top'
  get 'home/about'
end