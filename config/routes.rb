Rails.application.routes.draw do

  get 'pics/destroy'
  resources :albums
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: "index#index"
  root to: "index#discover"
  resources :photos
  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "logout" => "devise/sessions#destroy"
  end
  get "userProfile" => "index#editUserProfile"
  get "feed" => "index#feed"
  get "profile/:id" => "index#profile", as: 'profile'
  #get 'info/:id', to: "feed#info", as: 'info'
  delete 'pic/:id' => 'pics#destroy', as: 'pic'

  # post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  # post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  post "follow", to: "index#follow"
  post "unfollow", to: "index#unfollow"
  # post "like/album/:id_album", to: "index#like", as: "like/album"
  # delete "like/album/:id_album", to: "index#unlike", as: "unlike/album"
  post "like/photo/:id_photo", to: "index#like_photo", as: "like/photo"
  post "like/album/:id_album", to: "index#like_album", as: "like/album"
end

