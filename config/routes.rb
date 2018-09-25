Gera::Engine.routes.draw do
  resources :payment_systems do
  resources :direction_rate_history_intervals, only: [:index]
  resources :currencies, only: [:index]
  resources :direction_rates do
    member do
      get :last
    end
    collection do
      get :diff
      get :minimals
    end
  end
  resources :external_rates, only: [:index, :show]
  resources :external_rate_snapshots, only: [:index, :show]
  resources :currency_rates do
    collection do
      get :brief, to: redirect('https://operator.kassa.cc/currency_rates')
    end
  end
  resources :currency_rate_modes, only: [:edit, :update, :new, :create]
  resources :currency_rate_mode_snapshots, only: [:index, :edit, :update, :show, :create] do
    member do
      post :activate
    end
  end
  resources :rate_sources

  # get :tables_sizes, to: 'dashboard#tables_sizes'
end
