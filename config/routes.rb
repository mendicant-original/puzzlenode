Puzzlenode::Application.routes.draw do
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/logout', :to => 'sessions#destroy'
  match '/login',  :to => 'sessions#new'
end
