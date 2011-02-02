Puzzlenode::Application.routes.draw do
  root :to => 'home#index'

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/logout', :to => 'sessions#destroy'
  match '/login',  :to => 'sessions#new'
end
