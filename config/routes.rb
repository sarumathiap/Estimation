Rails.application.routes.draw do
  



  
  get 'dummy/index'
  post '/selectdata', to: 'moduls#selected', as: 'selectdata'
get '/selects', to: 'moduls#selected', as: 'selects'
 resources :timechanges
  get 'timechanges/new'

  post 'timechanges/create'

   get 'auth/:provider/callback', to: 'sessions#create' 
  get 'auth/failure', to: 'users#new'
  get 'signout', to: 'sessions#destroy', as: 'signout'


  resources :sessions

get 'infos/new', to: 'infos#new', as: 'in'
  resources :moduls
  resources :epics
  resources :stories
  resources :subtasks
  resources :home
  resources :enduser
 

 root 'moduls#index'
 get '/button', to: 'timechanges#button', as: 'button'
get '/but', to: 'timechanges#but', as: 'but'
get '/butt', to: 'moduls#butt', as: 'butt'
post '/exist', to: 'infos#existing', as: 'exist'
get '/exists', to: 'infos#existing', as: 'exists'

#post '/butt', to: 'moduls#button', as: 'butt'
 resources :users

    resources :infos do


  member do
    put 'confirm'
     post 'edit_role'

  end
end
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
