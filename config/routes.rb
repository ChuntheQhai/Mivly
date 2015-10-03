Rails.application.routes.draw do
  root 'urls#index'
  resources :urls
  get '/:id' => 'urls#show'
  get '/refresh/list' => 'urls#show_partial'
  get '/refresh/form' => 'urls#_form'
end

