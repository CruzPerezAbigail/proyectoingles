Rails.application.routes.draw do
  resources :documentos
  devise_for :user, :controllers => {
    :registrations => "devise/registrations",
    :sessions => "devise/sessions",
    :passwords => "devise/passwords",
    :confirmations => "devise/confirmations"
  }

  devise_scope :devise do 
    get 'signup', to: 'devise/registrations#new'
    get 'sign_in', to: 'devise/sessions#new'
    get 'signout', to: 'devise/sessions#destroy'
  end 

  
 
  
  root to: 'home#index'
   
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #root to: 'home#index',  as: 'administrador_root',
  #constraints: lambda { |request| !request.env['warden'].user.administrador? }

  #root to: 'ingles/home#ingles', as: 'ingles_root',
   # constraints: lambda { |request| request.env['warden'].user.ingles? }
  
  #root to: 'financieros/home#financieros', as: 'financieros_root',
   # constraints: lambda { |request| request.env['warden'].user.financieros? }

    #root to: 'servicios/home#serviciosescolares', as: 'serviciosescolares_root',
    #constraints: lambda { |request| request.env['warden'].user.servicios? }

    #root to: 'direccion/home#direccion', as: 'direccion_root',
    #constraints: lambda { |request| request.env['warden'].user.direccion? }
    #authenticated do
     
     # root :as => 'home#ingles', :constraints => lambda{ |req| req.session['warden.user.user.ingles'][0] == 'ingles' }
     #root :as => 'home#financieros', :constraints => lambda{ |req| req.session['warden.user.user.financieros'][0] == 'financieros ' }
    #end
end

