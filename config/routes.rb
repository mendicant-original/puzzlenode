Puzzlenode::Application.routes.draw do
  match '/auth/:provider/callback', :to => 'sessions#create'
end
