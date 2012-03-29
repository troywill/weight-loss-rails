Troy::Application.routes.draw do
  root :to => 'welcome#index'

  resources :settings
  resources :readings
  resources :users
  
  get "welcome/index"
  get "welcome/graph"
  get "welcome/two_year_graph"
  get "welcome/login"
  post "welcome/login"
  get "welcome/logout"

  get "weight_graph/week"
  get "weight_graph/month"
  get "weight_graph/year"

end
