Upstatus::Application.routes.draw do
  get "services/index"

  devise_for :admins
  resources  :services

  root :to => "dashboard#index"
end
