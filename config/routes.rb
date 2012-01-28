Puzzlenode::Application.routes.draw do

  root :to => 'puzzles#index'

  match '/auth/:provider/callback',      :to => 'sessions#create'
  match '/auth/failure',                 :to => 'sessions#failure'
  match '/logout' => 'sessions#destroy', :as => 'logout'
  match '/login' => 'sessions#new',      :as => 'login'

  match '/puzzles/:slug/attachments/:file', :to => 'puzzles#attachments',
                                            :as => "attachment"

  resources :puzzles do
    resources :submissions, :controller => "Puzzles::Submissions"
    resources :comments,    :controller => "Puzzles::Comments"
  end

  match '/tags/:tag',                     :to => 'puzzles#tag',
                                          :as => "tag"

  resources :users do
    resources :submissions, :controller => "Users::Submissions"
  end

  resources :announcements

  match '/leaderboard', :to => "leaderboard#index"

  namespace :admin do
    resources :users
    resources :puzzles
    resources :announcements

    match "/" => 'puzzles#index', :as => 'admin'
  end

  match 'markdown/parse' => 'markdown#parse', :as => "parse_markdown"
  get "slugger" => "slugger#index", :as => "slugger"
end
