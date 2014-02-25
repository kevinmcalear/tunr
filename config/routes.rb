Tunr::Application.routes.draw do
  resources :artists do
    resources :songs, except: [:index, :show], shallow: true do
      resources :purchases, only: [:create]
    end
  end

  resources :users do
    resources :songs, only: [:index]
    resources :playlists, only: [:new, :create, :show], shallow: true
    resources :playlists_user, only: [:new, :create]
  end

  resources :playlists do
    resources :playlists_user, only: [:new, :create]
  end

  #resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "session#new"
  post "/session", to: "session#create"
  delete "/session", to: "session#destroy"

  root "welcome#index"
end