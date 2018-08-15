Rails.application.routes.draw do
  root 'my_profiles#index'

  resources :profile_comments
  post '/profile_comments/spin_comment', to: "profile_comments#spin_comment", as: 'spin_comment'

  resources :my_profile_statistics
  resources :my_profiles do
    get 'fetch_users', to: 'my_profiles#fetch_users', as: 'fetch_users'
  end
  get '/my_profile/:id', to: 'my_profiles#automated_profile_promotion', as: 'automated_profile_promotion'
  post '/follow_people/:id', to: 'my_profiles#follow_people', as: 'follow_people'
  get '/unfollow_people/:id', to: 'my_profiles#unfollow_people', as: 'unfollow_people'
  get '/test/:id', to: 'my_profiles#test', as: 'test'
  
  
  resources :pages do
    resources :photos
  end
  get '/page/:page_id/fetch_photos', to: 'photos#fetch_all_photos_of_page', as: 'fetch_pages_photos'

  resources :photos do
    resources :comments
    resources :likes
  end

  resources :users
  get '/update_users_details', to: 'users#update_users_details', as: 'update_users_details'
  get '/delete_unwanted_users', to: 'users#delete_unwanted_users', as: 'delete_unwanted_users'
end
