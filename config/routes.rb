Myapp::Application.routes.draw do
  devise_for :users
  #get "home/index"
  root to: 'home#index'
  get   'kurs'        => 'home#kurs', as:"kurs"
  resources :questions, only: [:index, :create, :update, :delete, :new, :show]  do
    resources :answers, only: [:index, :create, :update, :delete, :new]
  end

  resource :question, only:[] do 
    post  ':id/vote_up'   => 'questions#vote_up', on: :collection, as:"vote_up"
    post  ':id/vote_down' => 'questions#vote_down', on: :collection, as:"vote_down"
  end

  resource :user, only:[] do 
    get  ':user_name'   => 'users#timeline', on: :collection, as:"timeline"
  end
end
