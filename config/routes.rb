Rails.application.routes.draw do
  resources :payments
  # get '/admin', to: 'home#index', can: :access, resource: :administrador_panel
  # get '/ingles', to: 'home#ingles', can: :access, resource: :ingles_panel
  # get '/financieros', to: 'home#financieros', can: :access, resource: :financieros_panel
  # get '/direccion', to: 'home#direccion', can: :access, resource: :direccion_panel
  # get '/servicios', to: 'home#servicios', can: :access, resource: :servicios_panel
  resources :anexos

    resources :archivos 
   
  resources :documentos
  
  
  get 'ingles', to: 'home#ingles'
  get 'financieros', to: 'home#financieros'
  get 'direccion', to: 'home#direccion'
  get 'servicios', to: 'home#serviciosescolares'
  root  'home#index'

  devise_for :user
    authenticated :user do
      root 'home#index', as: :admin_root
    end
    
    authenticated :ingles do
      root 'home#ingles', as: :ingles_root
    end
    
    authenticated :financieros do
      root 'home#financieros', as: :financieros_root
    end
    authenticated :servicios do
      root 'home#serviciosescolares', as: :servicios_root
    end
  


   devise_scope :devise do 
     get 'signup', to: 'devise/registrations#new'
     get 'sign_in', to: 'devise/sessions#new'
     get '/user/sign_out', to: 'user#sign_out'
    
   end 
end

