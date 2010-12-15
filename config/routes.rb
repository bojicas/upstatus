Upstatus::Application.routes.draw do

  root :to => "dashboard#index"
  devise_for :admins
  resources  :services, :issues, :except => :show

end
