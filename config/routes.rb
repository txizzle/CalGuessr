Calguessr::Application.routes.draw do
  resources :questions
  resources :games
  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "about", to: "pages#about", as: "about"
  get "inside", to: "pages#inside", as: "inside"
  get "highscores", to: "pages#highscores", as: "highscores"
  
  patch 'games/:id/next_question' => 'games#next_question', as: :games_next_question
  patch 'games/:id/prev_question' => 'games#prev_question', as: :games_prev_question

  post 'games/:id/make_guess' => 'games#make_guess', as: :games_make_guess

  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    
  end

end
