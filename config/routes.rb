Rails.application.routes.draw do
  resources :labels, only: [:show]

   resources :topics do
     resources :posts, except: [:index]
   end
#shallow nesting comments into posts
   resources :posts, only: [] do
   	 resources :comments, only: [:create, :destroy]
     resources :favorites, only: [:create, :destroy]
     post '/up-vote' => 'votes#up_vote', as: :up_vote
     post '/down_vote' => 'votes#down_vote', as: :down_vote
   end

   resources :users, only: [:new, :create, :show]

   resources :sessions, only: [:new, :create, :destroy]
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
