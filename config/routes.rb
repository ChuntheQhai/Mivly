Rails.application.routes.draw do
  root 'urls#index'
  resources :urls
  get '/:id' => 'urls#show'
end
