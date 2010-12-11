Upstatus::Application.routes.draw do
  get "services/index"

  devise_for :admins
  resources  :services
  resources  :issues

  root :to => "dashboard#index"
end
