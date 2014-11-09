Myapp::Application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  root to: 'home#index'
  
  devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks" }
  #get "home/index"
  resource :user, only: []  do
    post  'be_subscriber'         => 'users#be_subscriber', on: :collection, as:"be_subscriber"
  end
  
  
  get   'kurs'        => 'home#kurs', as:"kurs"

  resources :questions, only: [:index, :create, :update, :delete, :new, :show]  do
    resources :answers, only: [:index, :create, :update, :delete, :new]
  end

  resource :question, only:[] do 
    post  ':id/vote_up'   => 'questions#vote_up', on: :collection, as:"vote_up"
    post  ':id/vote_down' => 'questions#vote_down', on: :collection, as:"vote_down"
  end

  resources :consultants

  # resource :user, only:[] do 
  # end
  
  resources :articles, only:[:index, :create, :update, :delete, :new, :show] do
    resources :comments, only: [:index, :create, :update, :delete, :new]
  end

  resources :rules, only:[:index, :create, :update, :delete, :new, :show] do
  end

  resource :question, only: [] do
    post  ':question_id/favourited'    => 'questions#favourited',   on: :collection,  as: "favourited"
    post  ':question_id/unfavourited'  => 'questions#unfavourited', on: :collection,  as: "unfavourited"
  end

  match '/profile/:id/finish_signup'      => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  get  '/profile/:id/finish_confirmation' => 'users#finish_confirmation', as:"finish_confirmation"
  get  'timeline'   => 'home#timeline', as:"timeline"
  get  'login'      => 'home#login',    as:"login"
  get  ':username'  => 'users#profile', as: "profile", constraints: {username: /((?!websocket).)*/}
  # get '/:hash', to: 'conversations#show', constraints: {hash: /((?!websocket).)*/}

  

  # resources :answers
end
