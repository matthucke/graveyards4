Rails.application.routes.draw do

  resources :users

  get 'book/:id' => 'book#show'
  get 'book' => 'book#index'

  get 'featured' => 'featured_sites#index'

  get "graveyards/:path" => "legacy#show", constraints: { :path => /[A-Z].*/ }

  get "graveyards" => "graveyards#index"
  # resources :graveyards, :only => [ :index ]

  resources :coordinates

  resources :counties

  get 'photos/debug', to: 'photos#debug'

  #get 'photos', to: 'photos#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  match '/auth/:provider/callback', to: 'sessions#create', :via => [ :get, :post ]

  # FALLBACK ROUTES - anything not covered above will go to these.
  get ':state', to: 'states#show'

  # resources :county_cemetery_lists, :only => [ :index, :show ]

  # /Illinois/Cook => Counties / show / Cook
  get ':state/:county/list', to: 'county_cemetery_lists#show'
  get ':state/:county/map', to: 'maps#index'
  get ':state/:county', to: 'counties#show'

  # /Illinois/Cook/Graceland => Graveyards / show /
  get ':state/:county/:graveyard/map', to: 'maps#show'
  get ':state/:county/:graveyard', to: 'graveyards#show'

end
