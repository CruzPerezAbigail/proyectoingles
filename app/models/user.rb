class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        
         has_one_attached :avatar
         
         def administrador?
          self.role == 'administrador'    
        end
        
        def ingles?
          self.role == 'ingles'
        end
        def financieros?
          self.role == 'financieros'
        end

        def servicios?
          self.role == 'servicios'
        end
        def direccion?
          self.role == 'direccion'
        end
      
      
end
