Rails.application.routes.draw do

  resources :photos do
    collection { get :debug }
  end

  resources :expeditions

  resources :articles, path: 'blog' do

  end

  # Special blog shortcut route.
  get 'about' => 'articles#show', id: 'about'

  resources :login, :only => [ :index ]

  resources :visits

  resources :users

  resource :profile


  get 'book/:id' => 'book#show'
  get 'book' => 'book#index'

  get 'featured' => 'featured_sites#index'

  # The "/graveyards/" url prefix is deprecated for everything but the Index.
  #
  # /graveyards => graveyards#index
  # /graveyards/IL/Cook/rosehill etc. goes to LegacyController which will redirect
  #
  # get "graveyards" => "graveyards#index"
  resources :graveyards do
    collection do
      # An exception - this url goes to a different controller.
      # /graveyards/IL/Cook/rosehill
      # v3.0 (2012-2014) - /graveyards/MO/St._Louis_City/Bellefontaine.kml
      get ":path" => "legacy#show", constraints: { path: /[A-Z].*/ }
    end
  end

  ## LEGACY PATHS.
  # v2.0 (2003-2007) - /list.php [?county=Cook ], /show.php?id=290
  # v2.5 (2007-2012) - /bin/grave?id=111
  # get "graveyards/:path" => "legacy#show", constraints: { :path => /[A-Z].*/ }
  # v3.0 (2012-2014) - /graveyards/MO/St._Louis_City/Bellefontaine.kml
  get 'graveyard' => 'legacy#show'
  get 'bin/grave' => 'legacy#show'
  get 'show.php' => 'legacy#show', defaults: { format: 'html' }
  get 'list.php' => 'legacy#show', defaults: { format: 'html' }

  resources :coordinates

  resources :counties


  #get 'photos', to: 'photos#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake rouppliatites".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # omniauth
  match '/auth/:provider/callback', to: 'sessions#create', :via => [ :get, :post ]
  get '/logout' => 'sessions#destroy'

  # FALLBACK ROUTES - anything not covered above will go to these.
  get ':state', to: 'states#show'

  # resources :county_cemetery_lists, :only => [ :index, :show ]

  # /Illinois/Cook => Counties / show / Cook
  get ':state/:county/list', to: 'county_cemetery_lists#show'
  get ':state/:county/map', to: 'maps#index'
  get ':state/:county', to: 'counties#show'

  # /Illinois/Cook/Graceland => Graveyards / show /
  get ':state_path/:county_path/:graveyard_path/map', to: 'maps#show'
  get ':state_path/:county_path/:graveyard_path', to: 'graveyards#show'

end
