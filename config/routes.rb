Puzzlenode::Application.routes.draw do
  root :to => 'puzzles#index'

  match '/auth/:provider/callback',      :to => 'sessions#create'
  match '/auth/failure',                 :to => 'sessions#failure'
  match '/logout' => 'sessions#destroy', :as => 'logout'
  match '/login' => 'sessions#new',      :as => 'login'

  resources :puzzles do
    resources :comments,    :module => "puzzles"
    resources :submissions, :module => "puzzles"
  end

  match '/tags/:tag',                     :to => 'puzzles#tag',
                                          :as => "tag"

  match '/users/settings' => 'users#edit', :as => "user_settings"
  resources :users do
    resources :submissions, :controller => "Users::Submissions" do
      match :rate, :on => :member, :via => [:put, :post]
    end
  end

  resources :announcements

  match '/leaderboard', :to => "leaderboard#index"

  namespace :admin do
    resources :users
    resources :puzzles
    resources :announcements

    match "/" => 'puzzles#index', :as => 'admin'
  end

  get "slugger" => "slugger#index", :as => "slugger"
end
