Upstatus::Application.routes.draw do
  devise_for :admins

  root :to => "dashboard#index"
end
