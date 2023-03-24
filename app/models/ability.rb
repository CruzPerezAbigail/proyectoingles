class Ability
  include CanCan::Ability

  def initialize(users)
    users ||= User.new
    if usuario.role == "administrador"
      can :access, :home_panel
    elsif user.role == "ingles"
      can :access, :ingles_panel
    elsif user.role == "financieros"
      can :access, :financieros_panel
    elsif user.role == "escolares"
      alias_action :create, :read, :update, :to => :cru
      elsif user.role== "direccion"
        alias_action :create, :read, :update, :to => :cru
     end
    end
   end