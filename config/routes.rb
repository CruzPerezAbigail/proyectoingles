Rails.application.routes.draw do

    resources :archivos 
    post 'archivos/subir_archivo' => 'archivos#subir_archivo'
  
  resources :documentos
  get '/descargar_pdf', to: 'documentos#descargar_pdf'
  get 'ingles', to: 'home#ingles'
  get 'financieros', to: 'home#financieros'
  get 'direccion', to: 'home#direccion'
  get 'servicios', to: 'home#serviciosescolares'

  devise_for :user, :controllers => {
    :registrations => "devise/registrations",
    :sessions => "devise/sessions",
    :passwords => "devise/passwords",
    :confirmations => "devise/confirmations"
  }

  # devise_scope :devise do 
  #   get 'signup', to: 'devise/registrations#new'
  #   get 'sign_in', to: 'devise/sessions#new'
  #   get 'signout', to: 'devise/sessions#destroy'
  # end 

  constraints ->(req) { req.session[:user_role] == 'administrador' } do
    # Rutas para el rol de administrador
    get '/admin/dashboard', to: 'admin#dashboard'
    # ...
  end

  constraints ->(req) { req.session[:user_role] == 'ingles' } do
    get 'ingles', to: 'home#ingles'
  end
  constraints ->(req) { req.session[:user_role] == 'financieros' } do
    get 'financieros', to: 'home#financieros'
  end
  constraints ->(req) { req.session[:user_role] == 'direccion' } do
    get 'direccion', to: 'home#direccion'
  end
  constraints ->(req) { req.session[:user_role] == 'servicio' } do
    get 'servicios', to: 'home#serviciosescolares'
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

