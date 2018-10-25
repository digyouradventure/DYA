Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  get "dya" => "top#index"
  get "trips/settle" => "trips#settle"
  get "trips/complete" => "trips#complete"
  post "trips/purchase" => "trips#purchase"
  resources :users, only:[:show, :edit, :update]
  resources :trips, only:[:show, :new, :create]
end
