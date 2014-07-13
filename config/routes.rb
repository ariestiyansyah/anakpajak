Myapp::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks" }
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

  resources :consultants

  resource :user, only:[] do 
    
  end
  resources :articles, only:[:index, :create, :update, :delete, :new, :show] do
  end
  resources :rules, only:[:index, :create, :update, :delete, :new, :show] do
  end
  get  'timeline'   => 'home#timeline', as:"timeline"
  get  'login'      => 'home#login',    as:"login"
  get  ':username'  => 'users#profile', as: "profile", constraints: {username: /((?!websocket).)*/}
  # get '/:hash', to: 'conversations#show', constraints: {hash: /((?!websocket).)*/}

  

  # resources :answers
end
