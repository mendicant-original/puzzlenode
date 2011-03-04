Puzzlenode::Application.routes.draw do
  root :to => 'puzzles#index'

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/logout', :to => 'sessions#destroy'
  match '/login' => redirect('/auth/github')
  
  resources :puzzles do
    resources :submissions, :controller => "Puzzles::Submissions"
    resources :comments, :controller => "Puzzles::Comments"
  end
  
  resources :users do
    resources :submissions, :controller => "Users::Submissions"
  end
  
  namespace :admin do
    resources :puzzles
  end
end
