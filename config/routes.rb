Rails.application.routes.draw do
  resources :posts, only: [:index, :new, :create, :edit, :update, :destroy]
  # get '/posts/new', to: 'posts#new', as: 'new_post'
  # get '/posts/:postid/edit', to: 'posts#edit', as: 'edit_post'
  # delete '/posts/:postid/destroy', to: 'posts#destroy', as: 'destroy_post'
  # patch '/posts/:postid', to: 'post#update'
  # get '/posts', to: 'posts#index', as: 'posts'
  # post '/posts', to: 'posts#create'
  # get '/post/:id', to: 'posts#show', as: 'post'
  get '/playlists/find_new_playlists', to: 'playlists#find_new_playlists', as: 'find_new_playlists'
  get '/playlists/:pid/songs/new', to: 'songs#new', as: 'new_song'
  get '/playlists/:pid/songs/:sid/edit', to: 'songs#edit', as: 'edit_song'
  delete '/playlists/:pid/songs/:sid/remove', to: 'playlist_songs#destroy', as: 'destroy_song_add'
  patch '/playlists/:pid/songs/:sid', to: 'songs#update'
  delete '/playlists/:pid/songs/:sid/destroy', to: 'songs#destroy', as: 'destroy_song'
  get '/playlists/:pid/songs/:sid', to: 'songs#show', as: 'song'
  get '/playlists/:pid/songs', to: 'songs#index', as: "songs"
  post '/playlists/:pid/songs', to: 'songs#create'
  post '/playlists/:pid/follows/create', to: 'follows#create', as: "new_follow"
  delete '/playlists/:pid/follows/destroy', to: 'follows#destroy', as: "destroy_follow"
  resources :playlists
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
end
