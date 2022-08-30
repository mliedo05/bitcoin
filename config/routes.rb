Rails.application.routes.draw do
  resources :cryptos, only: %i[create index destroy]
  
  root "cryptos#index"
end
