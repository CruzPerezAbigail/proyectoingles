class Ability
  include CanCan::Ability

  def initialize(users)
    users ||= User.new
    if usuario.role == "administrador"
      can :manage, :all
    elsif user.role == "ingles"
      alias_action :create, :read, :update, :to => :cru
             cru :Documento
    elsif user.role == "financieros"
      alias_action :create, :read, :update, :to => :cru
    elsif user.role == "escolares"
      alias_action :create, :read, :update, :to => :cru
      elsif user.role== "direccion"
        alias_action :create, :read, :update, :to => :cru
     end
    end
   end