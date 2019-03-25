Rails.application.routes.draw do
  get '/playlists/:pid/songs/:sid/edit', to: 'songs#edit', as: 'edit_song'
  patch '/playlists/:pid/songs/:sid', to: 'songs#update'
  delete '/playlists/:pid/songs/:sid/destroy', to: 'songs#destroy', as: 'destroy_song'
  get '/playlists/:pid/songs/:sid', to: 'songs#show', as: 'song'
  get '/playlists/:pid/songs/new', to: 'songs#new', as: 'new_song'
  resources :playlists
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
end
