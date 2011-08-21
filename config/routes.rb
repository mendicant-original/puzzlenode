Puzzlenode::Application.routes.draw do

  root :to => 'puzzles#index'

  match '/auth/:provider/callback',      :to => 'sessions#create'
  match '/logout' => 'sessions#destroy', :as => 'logout'
  match '/login' => 'sessions#new',      :as => 'login'

  resources :puzzles do
    resources :submissions, :controller => "Puzzles::Submissions"
    resources :comments,    :controller => "Puzzles::Comments"
  end

  match '/tags/:tag',                     :to => 'puzzles#tag',
                                          :as => "tag"
  match '/puzzles/:id/attachments/:file', :to => 'puzzles#attachments',
                                          :as => "attachment"

  resources :users do
    resources :submissions, :controller => "Users::Submissions"
  end

  resources :announcements

  match '/leaderboard', :to => "leaderboard#index"

  ActiveAdmin.routes(self)

  match '/admin/logout' => 'sessions#destroy'
end
